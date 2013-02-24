class Channel < ActiveRecord::Base
  # Getters & Setters
  attr_accessible :name, :avatar

  # Associações
  has_many :users
  has_many :matches
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_attached_file :avatar, :styles => { :thumb => ["128x128#", :png] },
    :default_url => "avatars/channel/missing.gif"

  # Validação
  validates_presence_of :name
end
