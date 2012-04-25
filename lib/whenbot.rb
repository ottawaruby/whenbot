require "whenbot/version"
require "whenbot/channel"
require "whenbot/trigger"

module Whenbot

  # Note that we can't use autoload because we automatically detect 
  # Triggers/Actions when a Channel is added via #config. If the 
  # Triggers aren't loaded, # we can't use #constants to detect the 
  # Triggers.
  #
  # autoload :Channel,   'whenbot/channel'
  # autoload :Trigger,   'whenbot/trigger'

  # ==== One-liner 1 ====
  @@channels = []
  
  #
  # Relays the callbacks that come into the Whenbot#callback
  # action to the proper Trigger class.
  #
  def self.relay_callback(channel, trigger, triggers, url_params, headers, body)
    # ==== One-liner 2 ====
    if klass
      # ==== One-liner 3 ====
    else
      :error
    end
  end
  
  #  
  # Handles "config do" block. To be used from intializer.
  #
  def self.config
    # ==== One-liner 4 ====
  end
  
  #
  # Overloaded accessor to ensure that we always return an array
  #
  def self.channels
    Array(@@channels)
  end
  
  #
  # Returns an array of Channels that have at least one Trigger
  # Array values are strings. E.g. 'Developer'
  #
  def self.trigger_channels
    trigger_channels_as_consts.collect { |channel| # ==== One-liner 6 ==== }
  end

  #
  # Returns an array of Trigger Channels as constants. That is,
  # any Channels that have at least one Trigger.
  # 
  # E.g. Whenbot::Channels::Developer
  #
  def self.trigger_channels_as_consts
    channels.select do |channel|
      # ==== One-liner 7 ====
    end
  end
  
  #
  # Returns an array of Channels that have at least one Trigger
  #
  def self.action_channels
    # Task: Fill this in
  end  
  
  private    

  
  #
  # Helper method to find the constant for the given Channel and Trigger
  #
  def self.build_class_constant(channel, trigger)
    # ==== One-liner 8 ====
    klass = Whenbot::Channels::const_get(channel.camelize)::Triggers::const_get(trigger.camelize)
  rescue NameError => e
    # Happens if we can't find the Channel or Trigger.
    # Log, email exception (Exceptional? Hoptoad? New Relic?)
    Rails.logger.error "[ERROR] NameError. Message = #{e.message}"
    raise e
  end


  # 
  # Checks if there's at least one Trigger defined under the 
  # Channel's "Triggers" module.
  #
  def self.has_triggers?(channel)
    channel::Triggers::constants.present? if channel.const_defined?(:Triggers)
  end

  #
  # Helper method to return an array of Trigger's defined for the
  # given Channel
  #  
  def self.detect_triggers_for(channel)
    channel::Triggers::constants
  end
end
