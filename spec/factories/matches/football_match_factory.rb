FactoryGirl.define do
  factory :football_match do
    name "Minha Partida"
    type "FootballMatch"
    date Time.now
    channel { FactoryGirl.create :channel }
  end
end
