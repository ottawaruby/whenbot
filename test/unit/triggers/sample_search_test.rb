require 'test_helper'

class SampleSearchTest < ActiveSupport::TestCase

  def setup
    @sample_search_trigger = Whenbot::Channels::Developer::Triggers::SampleSearch

    @default_trigger = FactoryGirl.create(:trigger)
    @matching_trigger = FactoryGirl.create(:matching_trigger)
    
    @search_term = @matching_trigger.parameters[:search_term]
    @body_as_hash = { content: "Some text that mentions #{@search_term}" }
    @body = @body_as_hash.to_json
    @url_params = { url_data: "some data" }
    @headers = { 'Content-Type' => 'application/json' }

    @triggers, @trigger_ids = Trigger.triggers_for('Developer', 'SampleSearch')  
    @returned_triggers, @returned_response = @sample_search_trigger.callback(@triggers, @url_params, @headers, @body)
  end
  
  #
  # Trigger API implementation
  #
  context "trigger API implementation" do
    
    should "have a #callback method" do
      assert_respond_to @sample_search_trigger, :callback, "Doesn't have a #callback method"
    end    
    
  end

  #
  # Callback method
  #
  context "callback method" do

    should "return an array of Triggers for a given channel and trigger" do
      assert_kind_of Array, @returned_triggers, "return value is not an Array"
    end
    
    should "contain a hash" do
      @returned_triggers.each do |trigger|
        assert_kind_of Hash, trigger, "Array did not contain hashes"
      end
    end
    
    should "have a :parameters key for each trigger" do
      @returned_triggers.each do |trigger|
        assert trigger.has_key?(:parameters), "should have :parameters key"
      end
    end
    
    should "populate :parameters hash with saved parameters as a hash" do
      @returned_triggers.each do |trigger|
        assert_not_nil trigger[:parameters], ":parameters should not be nil"
        assert_kind_of Hash, trigger[:parameters], ":parameters key is not a Hash"
      end

      @default_trigger.parameters.keys.each do |key|
        assert @triggers[0][:parameters].keys.include?(key), ":parameters hash is missing a \"#{key}\" key"
      end
    end
    
    should "still have a hash called :match_data for each trigger" do
      @returned_triggers.each do |trigger|
        assert trigger.has_key?(:match_data), "trigger didn't have a :match_data key"
        assert_kind_of Hash, trigger[:match_data], "trigger[:match_data] wasn't a Hash"
        assert_not_nil trigger[:match_data], "trigger[:match_data] should not be nil"
      end
    end
    
    should "have a hash called :extra_data for each trigger" do
      @returned_triggers.each do |trigger|
        # Note: This hash can contain data, if the Trigger saved something there before.
        assert trigger.has_key?(:extra_data), "trigger didn't have an :extra_data key"
        assert_kind_of Hash, trigger[:extra_data], "trigger[:extra_data] wasn't a Hash"
      end
    end
    
    should "have a hash for :last_matched for each trigger" do
      @returned_triggers.each do |trigger|
        assert trigger.has_key?(:last_matched), "trigger didn't have a :last_matched key"
        assert_kind_of ActiveSupport::TimeWithZone, trigger[:last_matched], "trigger[:last_matched] wasn't a Time object"
        assert_not_nil trigger[:last_matched], "trigger[:last_matched] was nil"
      end
    end

    should "return original triggers array if no match found" do      
      # Update the matching trigger, which would return a match
      @matching_trigger.parameters = { search_term: 'no match' }
      @matching_trigger.save
      
      triggers, trigger_ids = Trigger.triggers_for('Developer', 'SampleSearch')
      triggers, response = @sample_search_trigger.callback(triggers, @url_params, @headers, @body)
      
      triggers.each do |trigger|
        assert trigger[:match_data].empty?, "Trigger's :match_data reported a match when there was none"
      end
    end

    should "update the :match_data of a trigger when a match is found" do
      triggers, response = @sample_search_trigger.callback(@triggers, @url_params, @headers, @body)
      triggers.each do |trigger|
        if trigger[:parameters][:search_term] == @search_term
          assert_not_nil trigger[:match_data], ":match_data was nil, when it should've been a Hash"
          assert !trigger[:match_data].empty?, "no :match_data was returned"
          assert trigger[:match_data].has_key?(:content), ":match_data did not have :content key"          
        end
      end
    end

    should "return match data if a match is found" do
      match_hash_found = false
      triggers, response = @sample_search_trigger.callback(@triggers, @url_params, @headers, @body)
      triggers.each do |trigger|
        if trigger[:parameters][:search_term] == @search_term
          match_hash_found = true
          assert !trigger[:match_data][:content].empty?
          assert_equal @body_as_hash[:content], trigger[:match_data][:content], "Did not find correct match"
        end
      end
      assert match_hash_found, "Didn't find a match"
    end
    
  end

end