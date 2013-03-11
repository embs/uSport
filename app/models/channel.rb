class Channel < ActiveRecord::Base
  # Getters & Setters
  attr_accessible :name, :description, :avatar

  # Associações
  has_many :user_channel_associations, dependent: :destroy
  has_many :users, through: :user_channel_associations
  has_many :user_favorite_channels, dependent: :destroy
  has_many :favorited_users, through: :user_favorite_channels, source: :user
  has_many :matches
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_attached_file :avatar, styles: { :thumb => ["128x128#", :png] },
    default_url: "avatars/channel/missing.gif"

  # Validação
  validates_presence_of :name
end
