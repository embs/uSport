FactoryGirl.define do
  factory :match do
    name "Minha Partida"
    type "FootballMatch"
    date Time.now
    channel { FactoryGirl.create :channel }
  end
end