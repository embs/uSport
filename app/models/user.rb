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
  has_many :favorite_channels, through: :user_favorite_channels,
           source: :channel
  has_many :comments
  has_many :authentications, dependent: :destroy
  has_attached_file :avatar, storage: :dropbox,
    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
    default_url: "avatars/missing.gif",
    styles: { :thumb => ["128x128#", :png], mini: ["27x27#", :png] },
    dropbox_options: {
      path: Proc.new { |style| "users/#{id}/#{style}/#{avatar.original_filename}" }
    }

  # Validações
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username

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
