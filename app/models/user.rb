class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :username
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username
  has_many :channels, :through => :user_channel_association
  has_many :user_channel_association
end
