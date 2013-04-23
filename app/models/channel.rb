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
    default_url: "avatars/missing.gif",
    storage: :dropbox, dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
    dropbox_options: {
      path: Proc.new { |style| "channels/#{id}/#{style}/#{avatar.original_filename}" }
    }

  # Validação
  validates_presence_of :name

  def is_favorite_of?(user)
    return false unless user
    user.favorite_channels.include?(self)
  end
end
