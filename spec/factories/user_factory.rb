# encoding: utf-8
FactoryGirl.define do
  factory :user do
    first_name 'João'
    last_name 'da Silva'
    sequence :email do
      |n| "joaodasilva#{n}@example.com"
    end
    sequence :username do
      |n| "joaodasilva#{n}"
    end
    password '12345678'
  end
end
