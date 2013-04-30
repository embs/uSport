# encoding: utf-8
FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence :email do |n|
      "#{n}#{Faker::Internet.free_email}"
    end
    sequence :username do |n|
      "#{Faker::Internet.user_name}12345#{n}"
    end
    password '12345678'
  end
end
