class Action < ActiveRecord::Base
  belongs_to :task

  serialize :parameters, Hash
  serialize :extra_data, Hash  
  attr_accessible :channel, :action, :parameters, :active
end
