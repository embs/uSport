class Match < ActiveRecord::Base
  attr_accessible :date, :name, :type, :value1, :value2
  validates_presence_of :date, :name
  has_many :moves
  has_many :teams
  belongs_to :channel
end
