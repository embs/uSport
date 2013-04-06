class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :username, :avatar

  # Associações
  has_many :user_channel_associations, dependent: :destroy
  has_many :channels, through: :user_channel_associations
  has_many :user_favorite_channels, dependent: :destroy
  has_many :favorite_channels, through: :user_favorite_channels, source: :channel
  has_many :comments
  has_many :authentications, dependent: :destroy
  has_attached_file :avatar, styles: { :thumb => ["128x128#", :png],
    mini: ["27x27#", :png] }, default_url: nil

  # Validações
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username

  def self.create_with_omniauth(auth)
    User.create do |user|
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      user.email = auth['info']['email']
      user.username = auth['info']['nickname']
      user.password = '#TODO678' #TODO Gerar um password válido e difícil
    end
  end

  def display_name
    "#{self.first_name} #{self.last_name}"
  end
end
