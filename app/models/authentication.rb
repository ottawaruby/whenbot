class Authentication < ActiveRecord::Base
  serialize :parameters, Hash
  attr_accessible :channel, :parameters
end
