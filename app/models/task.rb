class Task < ActiveRecord::Base
  # ==== One-liner 18 ====
  # ==== One-liner 19 ====
  
  accepts_nested_attributes_for :triggers, :actions
  
  # ==== One-liner 20 ====
  
  #
  # Handles calling the appropriate Trigger's #callback method,
  # saves the match data to the table, and runs the Action(s) if
  # its conditions are met.
  #
  def self.handle_callback(channel, trigger, params, headers, body)
    triggers, trigger_ids = Trigger.triggers_for(channel, trigger)    
    returned_triggers, response = Whenbot.relay_callback(channel, trigger, triggers, params, headers, body)
    # ==== One-liner 21 ====
    # ==== One-liner 22 ====
  end 
  
end
