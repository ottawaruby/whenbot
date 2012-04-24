require 'test_helper'

class TriggerConformanceTest < ActiveSupport::TestCase

  setup do
    # Pick a trigger to test
    @test_trigger = Whenbot::Channels::Developer::Triggers::SampleSearch
  end

  #
  # Trigger API implementation
  #
  context "Trigger API implementation" do
    
    should "include Whenbot::Trigger module" do
      assert @test_trigger.included_modules.include?(Whenbot::Trigger), "Doesn't include Whenbot::Trigger module"
    end

    # Depends on #set_option being implemented. 
    # See lib/whenbot/trigger.rb for the task.
    #
    # should "set use #set_option to set display_title value" do      
    #   assert_not_nil @test_trigger.options[:display_title], "Did not set display title"
    # end
    
  end

  #
  # #callback method
  #
  context "#callback method" do
    
    should "exist" do
      assert_respond_to @test_trigger, :callback, "Doesn't have a #callback method"
    end

  end

  #
  # #poll? method
  #
  context "polling" do
    
    should "have an #is_polling_trigger" do
      assert_respond_to @test_trigger, :is_polling_trigger?, "Doesn't have an #is_polling_trigger method"
    end
  
    should "return a true of false value from #is_polling_trigger?" do
      result = @test_trigger.is_polling_trigger?
      assert result == true || result == false, "Didn't return a true or false value"
    end

    should "respond to #poll if #is_polling_trigger? returns true" do
      polling = @test_trigger.is_polling_trigger?
      if polling
        assert_respond_to @test_trigger, :poll, "Doesn't have a #poll method"
      end
    end
    
    # Add other tests here, then implement.
    #
    # See: https://github.com/ottawaruby/whenbot/wiki/Whenbot-Channel-Creation-(Examples)
    # for more details.
    #
  end  
  
  # 
  # #is_polling_trigger? method
  #
  context "#is_polling_trigger? method" do

    should "exist" do
      assert_respond_to @test_trigger, :is_polling_trigger?, "Doesn't have an #is_polling_trigger? method"
    end
  
    should "return a true of false value" do
      result = @test_trigger.is_polling_trigger?
      assert result == true || result == false, "Didn't return a true or false value"
    end

    # Add other tests here, then implement.
  end 
  
  # 
  # #parameters method
  #
  context "#parameters method" do

    should "exist" do
      assert_respond_to @test_trigger, :parameters, "Doesn't have a #parameters method"
    end
  
    should "return a hash" do
      # Task: fill this in
    end
    
    should "contain a :parameters key in the returned hash" do
      # Task: fill this in
    end

    # Add other tests here, then implement.
  end
  

  

end