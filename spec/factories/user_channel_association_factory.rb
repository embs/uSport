# encoding: utf-8
FactoryGirl.define do
  factory :user_channel_association do
    user { FactoryGirl.create :user }
    channel { FactoryGirl.create :channel }
  end
end
