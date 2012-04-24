require 'test_helper'

class WhenbotTest < ActiveSupport::TestCase

  
  
  # test 'can return a list of Trigger Channels' do
  #   channels = Whenbot.trigger_channels
  #   assert_not_nil channels, "No channels were returned"
  #   assert channels.is_a? Enumerable, "Did not return an enumerable list"    
  # end
  # 
  # test "including a Trigger adds it to the trigger_channels list" do
  #   Whenbot.channels = nil
  #   assert Whenbot.channels.empty?, "Could not clear Whenbot.channels list"
  #   puts "Whenbot.trigger_channels = #{Whenbot.trigger_channels.inspect}"
  #   assert Whenbot.trigger_channels.empty?, "trigger_channels list should be empty"
  #   
  #   klass = Whenbot::Channels::Twitter::Triggers::NewTweetFrom
  #   Whenbot::Trigger.send :included, klass
  #   trigger_channels = Whenbot.trigger_channels
  #   assert Whenbot.trigger_channels.include? klass, "trigger_channels should include #{klass}"    
  # end
  # 
  # test 'including the Trigger module adds the trigger to trigger_channels' do
  #   # ... write a better test?
  # end
end