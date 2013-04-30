class User < ActiveRecord::Base
  extend Enumerize

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :username, :avatar, :tos

  # Atributos
  enumerize :role, in: [:admin, :user], default: :user

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associações com canais
  has_many :user_channel_associations, dependent: :destroy
  has_many :channels, through: :user_channel_associations
  has_many :user_favorite_channels, dependent: :destroy
  has_many :favorite_channels, through: :user_favorite_channels,
           source: :channel

  # Associações com times
  has_many :user_team_associations, dependent: :destroy
  has_many :teams, through: :user_team_associations

  # Associações diversas
  has_many :comments
  has_many :authentications, dependent: :destroy
  has_attached_file :avatar, USport::Application.config.paperclip_user

  # Validações
  validates_presence_of :first_name, :last_name, :email, :username, :role
  validates_uniqueness_of :username
  validates :tos, acceptance: true
  validates_length_of :username, in: 5..50

  def self.create_with_omniauth(auth)
    User.create do |user|
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      user.email = auth['info']['email']
      user.username = choose_nick(auth['info']['nickname'], auth['info']['first_name']+auth['info']['last_name'], (-1))
      user.password = '#TODO678' #TODO Gerar um password válido e difícil
    end
  end

  def display_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def self.choose_nick(nick, name, counter)
    if nick
      if counter == (-1)
        new_nick = nick
      else
        new_nick = nick+(counter.to_s)
      end
      user = User.find_by_username(new_nick)
      if user
        choose_nick(nick, name, counter+1)
      else
        new_nick
      end
    else
      choose_nick(name, name, counter)
    end
  end
end
