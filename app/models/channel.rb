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
  has_attached_file :avatar, USport::Application.config.paperclip_channel

  # Validação
  validates_presence_of :name
  validates_length_of :name, in: 5..50

  def is_favorite_of?(user)
    return false unless user
    user.favorite_channels.include?(self)
  end
end
