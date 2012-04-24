class Trigger < ActiveRecord::Base
  # ==== One-liner 23 ====
    
  # ==== One-liner 24 ====
  # ==== One-liner 25 ====
  # ==== One-liner 26 ====
  # ==== One-liner 27 ====
  # ==== One-liner 28 ====
  # ==== One-liner 29 ====
  
  
  #
  # Returns all active triggers for the requested Channel and Trigger
  #
  def self.triggers_for(channel, trigger)
    records = where("channel = ? AND trigger = ?", channel.to_s.camelize, trigger.to_s.camelize).
              select([:id, :channel, :trigger, :parameters, :match_data, :extra_data, :last_matched]).
              active
    convert_for_matching(records)
  end

  #
  # Saves triggers that either have their :save or
  # :matched flag set
  def self.save_updated_triggers(triggers, trigger_ids)
    save_updated_hash(triggers, trigger_ids)
  end
  
  private
  
  #
  # Creates an array of hashes to be passed to the Trigger
  # via its #callback method. The Trigger will fill in
  # the array[n][:match_data] if there's a match, and
  # can use array[n][:extra_data] to store data that
  # it may need later.
  #
  # Another array of ids is returned to keep track of
  # which records should be updated.
  #
  # We do this to avoid passing around actual records. 
  # A Trigger only needs to concern itself with certain
  # things, and shouldn't be playing with table data.
  #
  # Hash Values:
  #
  #   :save => Signals that the hash was updated and
  #            should be saved
  #   :matched => New match was found, and stored in 
  #               :match_data. Data will be saved
  #               even if :save isn't set to true
  #   :parameters => Parameters saved from the user
  #   :match_data => Match data that's saved to be
  #                  used by the Action (i.e. the 
  #                  data to be used by Liquid)
  #   :extra_data => Use this to store any data
  #                  you want to receive next time
  #   :last_matched => Time that this Trigger last 
  #                    had a match.
  def self.convert_for_matching(records)
    array = Array.new
    ids_array = Array.new
    
    triggers = Array(records)
    triggers.each do |trigger|
      hash = Hash.new
      hash[:save] = false
      hash[:match_found] = false
      hash[:parameters] = trigger.parameters || {}
      hash[:match_data] = trigger.match_data || {}
      hash[:extra_data] = trigger.extra_data || {}
      hash[:last_matched] = trigger.last_matched
      array << hash
      ids_array << trigger.id 
    end
    return array, ids_array
  end
      
  def self.save_updated_hash(triggers, trigger_ids)
    triggers.each_with_index do |trigger, index|
      if trigger[:save] || trigger[:match]
        record = Trigger.find(trigger_ids[index]) 

        if trigger[:save]
          trigger.each_pair do |key, value|
            record.send("#{key}=", value) if record.respond_to? "#{key}=".to_sym
          end
        elsif trigger[:match_found]
          record.match_data = trigger[:match_data] 
        end
                
        record.save! if record.changed?
      end
    end
  end
end
