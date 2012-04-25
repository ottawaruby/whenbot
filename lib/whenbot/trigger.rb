require "active_support/core_ext/class/attribute"

module Whenbot
  module Trigger
    
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      
      # Use this when setting :last_matched value
      def current_time
        # ==== One-liner 11
      end

    end
  end
end