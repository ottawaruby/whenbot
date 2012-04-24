require 'test_helper'

class TriggerTest < ActiveSupport::TestCase

  #
  # Options and Configuration
  #
  context "options and configuration" do
    
    setup do
      @sample_search_trigger = Whenbot::Channels::Developer::Triggers::SampleSearch
    end
  
    should "allow a new option to be set for itself with #option" do
      display_title_text = "Sample Search Trigger"
      @sample_search_trigger.set_option :display_title, display_title_text    
      assert_equal display_title_text, @sample_search_trigger.options[:display_title]
    end
    
    should "keep options separate for separate Triggers" do
      twitter_trigger = Whenbot::Channels::Twitter::Triggers::NewTweetFrom
      
      twitter_display_text = "New tweet from"
      sample_search_display_text = "Sample Search"
      
      @sample_search_trigger.set_option :display_title, sample_search_display_text
      twitter_trigger.set_option :display_title, twitter_display_text
      
      assert_not_equal @sample_search_trigger.options[:display_title], twitter_trigger.options[:display_title], "The display titles should be different. Are they sharing the same instance?"
    end      
    
  end

  #
  # Saved Trigger (model) data
  #
  # parameters is an array of hashes with the saved parameters, plus
  # hashes for :match_data, :extra_data and :last_matched.
  #
  
  context "triggers_for method" do
    
    setup do
      @default_trigger = FactoryGirl.create(:trigger)
      @matching_trigger = FactoryGirl.create(:matching_trigger)
      @saved_triggers_count = 2
      @triggers, @trigger_ids = Trigger.triggers_for('Developer', 'SampleSearch')      
    end
    
    should "return an array of Triggers for a given channel and trigger" do
      assert_kind_of Array, @triggers, "return value is not an Array"
    end

    should "only have one element in the array" do
      assert_equal @saved_triggers_count, @triggers.count, "Has more than one element in the array"
    end      
    
    should "return an array of Trigger IDs for a given channel and trigger" do
      assert_kind_of Array, @trigger_ids, "return value is not an Array"
    end
    
    should "have one ID entry in the array for each Trigger returned" do
      assert_equal @triggers.count, @trigger_ids.count, "IDs array didn't contain the same number of elements as the Triggers array"
    end
    
    should "contain a hash" do
      @triggers.each do |trigger|
        assert_kind_of Hash, trigger, "Array did not contain hashes"
      end
    end
    
    should "have a :parameters key for each trigger" do
      @triggers.each do |trigger|
        assert trigger.has_key?(:parameters), "should have :parameters key"
      end
    end
    
    should "populate :parameters hash with saved parameters as a hash" do
      @triggers.each do |trigger|
        assert_not_nil trigger[:parameters], ":parameters should not be nil"
        assert_kind_of Hash, trigger[:parameters], ":parameters key is not a Hash"
      end

      @default_trigger.parameters.keys.each do |key|
        assert @triggers[0][:parameters].keys.include?(key), ":parameters hash is missing a \"#{key}\" key"
      end
    end
    
    should "have an empty hash called :match_data for each trigger" do
      @triggers.each do |trigger|
        assert trigger.has_key?(:match_data), "trigger didn't have a :match_data key"
        assert_kind_of Hash, trigger[:match_data], "trigger[:match_data] wasn't a Hash"
        assert trigger[:match_data].empty?, "trigger[:match_data] wasn't empty"
        assert_not_nil trigger[:match_data], "trigger[:match_data] should not be nil"
      end
    end
    
    should "have a hash called :extra_data for each trigger" do
      @triggers.each do |trigger|
        # Note: This hash can contain data, if the Trigger saved something there before.
        assert trigger.has_key?(:extra_data), "trigger didn't have an :extra_data key"
        assert_kind_of Hash, trigger[:extra_data], "trigger[:extra_data] wasn't a Hash"
      end
    end
    
    should "have a hash for :last_matched for each trigger" do
      @triggers.each do |trigger|
        assert trigger.has_key?(:last_matched), "trigger didn't have a :last_matched key"
        assert_kind_of ActiveSupport::TimeWithZone, trigger[:last_matched], "trigger[:last_matched] wasn't a Time object"
        assert_not_nil trigger[:last_matched], "trigger[:last_matched] was nil"
      end
    end
    
    should "return appropriate results with symbols as input" do
      assert_nothing_raised do
        triggers, trigger_ids = Trigger.triggers_for(:developer, :sample_search)
        assert_not_nil triggers, "no triggers were returned"        
      end
    end    
    
    should "return appropriate results with underscorized strings as input" do
      assert_nothing_raised do
        triggers, trigger_ids = Trigger.triggers_for('developer', 'sample_search')
        assert_not_nil triggers, "no triggers were returned"
      end
    end
  end
end
