class Channel < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :users
  has_many :matches
end
