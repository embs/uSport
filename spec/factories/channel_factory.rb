FactoryGirl.define do
  factory :channel do
    name "Meu Canal"
    owner { FactoryGirl.create :user }
  end
end