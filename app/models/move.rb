class Move < ActiveRecord::Base
  attr_accessible :description, :kind, :minute, :player, :points, :quarter, :yards

  belongs_to :match
  belongs_to :player

  validates_presence_of :kind, :match
end
