class Player < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :number
  validates_presence_of :first_name, :last_name
end
