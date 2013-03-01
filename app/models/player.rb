class Player < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :number, :team_id
  validates_presence_of :first_name, :last_name
  validates_numericality_of :number, :greater_than_or_equal_to => 1
  belongs_to :team
  has_many :moves
end
