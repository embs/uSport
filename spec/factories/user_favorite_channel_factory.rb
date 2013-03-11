# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_favorite_channel do
    user { FactoryGirl.create(:user) }
    channel { FactoryGirl.create(:channel) }
  end
end
