FactoryGirl.define do
  factory :football_match do
    name "Minha Partida"
    type "FootballMatch"
    date Time.now
    channel { FactoryGirl.create :channel }

    before(:create) do |match|
      2.times { match.teams << FactoryGirl.create(:team) }
    end
  end
end
