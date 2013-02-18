class Team < ActiveRecord::Base
  attr_accessible :name, :players, :sport_type
  validates_presence_of :name, :sport_type
  has_many :players
  has_many :moves
  belongs_to :match
end
