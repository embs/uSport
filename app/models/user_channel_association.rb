class UserChannelAssociation < ActiveRecord::Base
  attr_accessible :channel_id, :user_id
end
