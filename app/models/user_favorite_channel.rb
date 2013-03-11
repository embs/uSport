class UserFavoriteChannel < ActiveRecord::Base
  attr_accessible :user, :channel
  belongs_to :user
  belongs_to :channel
end
