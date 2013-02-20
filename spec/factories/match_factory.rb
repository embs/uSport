FactoryGirl.define do
  factory :match do
    name "Minha Partida"
    type "FootballMatch"
    date Time.now
    channel { FactoryGirl.create :channel }

    factory :match_with_teams do
      after(:create) do |match|
        existents = Team.all.count
        if existents > 1
          2.times { match.teams << Team.find(rand(existents)+1) }
        else
          2.times { match.teams << FactoryGirl.create(:team_with_players) }
        end
      end
    end
  end
end