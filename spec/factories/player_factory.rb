FactoryGirl.define do
  factory :player do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    number { rand 101 }
    team { FactoryGirl.create(:team) }
  end
end
