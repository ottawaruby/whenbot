module Whenbot
  module Channels
    module Developer
      module Triggers
        class SampleSearch
          
          include Whenbot::Trigger

          # Note that the Channel's display title is taken by
          # the module name. In this case: Whenbot::Channels::Twitter
          # would yield "Developer" as the Channel name.
          
          # Task: Enable this functionality. See tests in trigger_test.rb
          #
          # set_option :display_title, 'SampleSearch trigger'
          # set_option :description, 'Does nothing. Always reports a match.'


          #
          # Is this a polling trigger?
          #
          # Note: When creating a webhook or polling a service, it is
          # important to set the callback URL to 
          # /webhooks/<channel_name>/<trigger_name>/callback
          # For example, this Trigger would use:
          # /webhooks/developer/sample_search/callback.
          #
          # Without this, your #callback method will never be called.
          #
          # - Returns false if this Trigger sets up a webhook to be notified
          #     of potential matches.
          #
          # - Returns true if #poll should be called periodically to allow
          #     this Trigger to check for matches.
          #
          def self.is_polling_trigger?
            true
          end          

          # 
          # Run poll. Calls out to Webservice (use your Channel's Service
          # class to hold common code for this).
          #
          # If your service doesn't poll, you don't need this method.
          #
          # triggers [Array] => An array of hashes. 
          #   - Each hash contains the same keys/values as those given
          #     in the #callback method.
          #
          def self.poll(triggers)
            #
            # Poll the service.
            # If you get the response back immediately
            #   [Do pretty much the same thing as #callback]
            #   - Check results
            #   - Update the triggers array of hashes with any match_data found
            #   - Set the appropriate flags to signal if Whenbot should save
            #     the updated data to the database
            #
            # If you receive the response back via a callback, be sure
            # to set your path to /whenbot/<channel_name>/<trigger_name>/callback
            #
            # For example, this Trigger would use:
            # /whenbot/developer/sample_search/callback
            #
          end
          
          # Optional. Only needed if this is Trigger can be watched via a webhook.
          #
          # Creates a webhook on the server for this Trigger, with
          # the given params.
          #
          # trigger => Trigger hash for this Trigger. Same as 
          #            the hash passed into #callback.
          #
          # Returns: wehbook_uid (string) => an identifier given by the webservice, 
          #   that is used to uniquely identify this hook.
          #
          def self.create_webhook_for(trigger)
            #
            # Note: When creating a webhook or polling a service, it is
            # important to set the callback URL to 
            # /whenbot/<channel_name>/<trigger_name>/callback
            # For example, this Trigger would use:
            # /whenbot/developer/sample_search/callback
            #
          end

          #
          # Cancels a webhook that has been setup on the server.
          # Called when a User deletes or deactivates a Trigger.
          #
          # webhook_uid => The unique id returned from create_webhook_for
          # trigger => Trigger hash for this Trigger. Same as 
          #            the hash passed into #callback.
          #
          # Returns: true or false.
          #
          def self.cancel_webhook_for(webhook_uid, trigger)
            # Optional. Only needed if this Trigger uses webhooks.
          end
          
          #
          # A form will be automatically generated when the User is
          # creating a Task, to get the required parameters.
          #
          # Returns: Hash of parameters to be obtained from the
          # user when setting up this Trigger, and then saved 
          # to the database.
          #
          # @return [Hash]
          #   Hash of the following form:
          #   
          #     {
          #       parameter_name: {
          #              label: <display label text>,
          #         input_type: <type>, # can be :text_field, :select, :checkbox, etc. 
          #          help_text: <help_text> # optional
          #           optional: <true or false> # Is this parameter mandatory?
          #           template: <true or false> # Should be parsed for Liquid data
          #       }
          #     }
          #
          #
          def self.parameters
            {
              search_term: {
                label: 'Search term',
                input_type: :text,
                help_text: 'Text to be reported back as the matched data', 
                optional: false,
                accepts_liquid: true                
              }
            }
          end
          
          #
          # Called by Whenbot whenever a new response is received 
          # from a web service for this Trigger.
          #
          # triggers [Array] => An array of hashes. Each hash contains:
          #   
          #   hash[:parameters] # => saved parameters
          #
          #   hash[:match_data] # => an empty hash, for you to fill with
          #                          your match data if a match is found.
          #
          #   hash[:extra_data] # => Use this to store/retrieve custom data
          #                          that you need from callback to callback.
          #                          Starts out empty, saves what you put in
          #                          and returns the previously saved data 
          #                          with each call to #callback.
          #
          #   hash[:last_matched] # => The last date and time the Trigger was
          #                            matched. Will be updated by Whenbot if
          #                            you update the :matched_data hash.
          #     
          # parameters [Hash] => params hash
          # headers [Hash] => Result of request.headers
          # body [String] => Result of request.body.read
          #
          # returns:
          #  - The original trigger_params array, but with
          #    updated :match_data where appropriate
          #  - An array containing [:status, :headers, :body] for
          #    the response to the server.
          # 
          def self.callback(triggers, url_params, headers, body)
            [find_matches(triggers, body), build_response(:ok)]
          end
                    
          private
          
          # This sort of method would be specific to your needs.
          # For this example Trigger, the data we need can be 
          # found in the body.
          def self.find_matches(triggers, body)
            return triggers unless body
            payload = json_to_hash(body)
            
            triggers.each do |trigger|
              if payload['content'].include? trigger[:parameters][:search_term]
                # Update the current trigger, since we have a match
                # This is how we signal a match.
                #
                # Note: When updating :last_matched, use the #current_time
                # method, to ensure that all times are in the correct timezone.

                trigger[:match_found] = true
                trigger[:match_data] = { content: payload['content'] }
                trigger[:last_updated] = current_time # To maintain integrity
                trigger[:save] = true
              end
            end

            triggers
          end
          
          def self.json_to_hash(data)
            ActiveSupport::JSON.decode(data)
          end
          
          # Support method to build the response hash
          #
          # For this example, we either return the challenge (sometimes
          # requested by a web service), or just return a status code.
          def self.build_response(status, headers=nil, body=nil)
            {
              head_only: true,
              status: status,
              type: nil, # Can be :json, :xml, :js
              headers: headers,
              body: body
            }
          end
        end
      end
    end
  end
end
