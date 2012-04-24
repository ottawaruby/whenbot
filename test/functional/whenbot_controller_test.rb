require 'test_helper'

class WhenbotControllerTest < ActionController::TestCase
  
  context "webhook callback access" do
    
    setup do
      @sample_search_trigger = Whenbot::Channels::Developer::Triggers::SampleSearch
      @matching = FactoryGirl.create(:matching_trigger)
      @non_matching = FactoryGirl.create(:non_matching_trigger)
      @search_term = @matching[:parameters][:search_term]
      
      @body_as_hash = { content: "Some text that mentions #{@search_term}" }
      @body = @body_as_hash.to_json
      @url_params = { url_data: "some data" }
      @headers = { 'Content-Type' => 'application/json' }      
    end
  
    should "route paths with Channel and Trigger to Whenbot#callback" do
      expected_params = { controller: 'whenbot', 
                              action: 'callback', 
                             channel: 'developer', 
                             trigger: 'sample_search' }
      assert_routing '/whenbot/developer/sample_search/callback', expected_params
    end
  
    should "relay received webhook data to appropriate Trigger's #callback method" do
      triggers, ids = Trigger.triggers_for('Developer', 'SampleSearch')
      @sample_search_trigger.expects(:callback).returns([triggers, {status: :ok}])
      
      # Task for reader (that's you): Use Fakeweb or VCR. 
      params = { channel: 'developer', trigger: 'sample_search'}      
      response = raw_post('callback', params, @body)
    end

  end  
end
