module Whenbot
  module Channels
    module Twitter
      module Triggers
        class NewTweetFrom

          include Whenbot::Trigger

          # Task: Enable this functionality. See tests in trigger_test.rb
          #
          # set_option :display_title, "New tweet posted by a user"
          # set_option :description, "Triggers whenever a new message is tweeted by "\
          #                          "a specific user."

          # Called by Whenbot whenever a new response is received 
          # from a web service for this Trigger.
          # body (string) => Result of request.body.read
          # headers (hash) => Result of request.headers
          def self.callback(triggers, url_params, headers, body)
            return [nil, build_response(:ok, nil, url_params[:challenge])] if url_params[:challenge]
            [find_matches(triggers, body), build_response(:ok, nil, nil)]
          end
          
          private
          
          # This sort of method would be specific to your needs.
          # For this example Trigger, the data we need can be 
          # found in the body.
          def self.find_matches(triggers, body)
            return triggers unless body
            payload = json_to_hash(body)
    
            triggers
          end
  
          def self.json_to_hash(data)
            ActiveSupport::JSON.decode(data)
          end
          
          # Support method to build the response hash
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