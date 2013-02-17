class Match < ActiveRecord::Base
  attr_accessible :date, :name, :type
  validates_presence_of :date, :name
  has_many :moves
end
