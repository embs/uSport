class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  attr_accessible :email, :first_name, :last_name, :username
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username
  has_many :channels, :through => :user_channel_association
  has_many :user_channel_association
  has_many :comments


end
