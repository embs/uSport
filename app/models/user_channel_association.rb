class UserChannelAssociation < ActiveRecord::Base
  attr_accessible :channel_id, :user_id, :channel, :user
  belongs_to :user
  belongs_to :channel
  validates_presence_of :user, :channel
end
