class Channel < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :users
  has_many :matches
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
end
