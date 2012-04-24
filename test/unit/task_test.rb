require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  
  context "handle_callback method" do
    
    setup do
      @channel = 'Developer'
      @trigger = 'SampleSearch'
      
      search_term = FactoryGirl.build(:matching_trigger).parameters[:search_term]
      @body_as_hash = { content: "Some text that mentions #{search_term}" }
      @body = @body_as_hash.to_json
      @url_params = { url_data: "some data" }
      @headers = { 'Content-Type' => 'application/json' }
    end
    
    should "call Whenbot#relay_callback to send the callback to the Trigger" do
      triggers, ids = Trigger.triggers_for('Developer', 'SampleSearch')      
      Whenbot.expects(:relay_callback).returns([triggers, {status: :ok}])
      Task.handle_callback(@channel, @trigger, @url_params, @headers, @body)
    end
    
    should "update the match_data column for the matching data" do
      matching = FactoryGirl.create(:matching_trigger)
      non_matching = FactoryGirl.create(:non_matching_trigger)
      triggers, trigger_ids = Trigger.triggers_for(@channel, @trigger)
 
      Task.handle_callback(@channel, @trigger, @url_params, @headers, @body)

      # The match_data field is a serialized hash, and is stored as YAML
      # in the database, so we have to convert it back before the test.
      match_data = Trigger.find(matching.id).match_data
      assert_equal @body_as_hash[:content], match_data[:content], "Body content wasn't saved"
     end
   
    should "return response" do
      response = Task.handle_callback(@channel, @trigger, nil, nil, nil)
      assert_kind_of Hash, response, "response was not a hash"
      assert response.has_key?(:status), "Did not have a status key"
      # Other keys are optional.
    end
    
    
  end
end
