FactoryGirl.define do
  factory :team do
    name 'Mariners'
    sport_type 'Futebol Americano'

    factory :team_with_players do
      ignore do
        players_count 15
      end

      after(:create) do |team, evaluator|
        FactoryGirl.create_list(:player, evaluator.players_count, team: team)
      end
    end
  end
end
