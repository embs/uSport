# encoding: utf-8
FactoryGirl.define do
  factory :comment do
    author { FactoryGirl.create(:user) }
    move { FactoryGirl.create(:move) }
    body "Esse lance foi simplesmente o mais incrível que eu já vi em toda vida!"
  end
end
