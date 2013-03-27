class UserObserver < ActiveRecord::Observer
  def after_create(user)
    channel = Channel.create(name: user.username) do |channel|
      channel.owner = user
    end
    user.channels << channel
  end
end
