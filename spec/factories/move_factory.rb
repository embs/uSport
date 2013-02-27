FactoryGirl.define do
  factory :move do
    match { FactoryGirl.create(:match) }
    player { FactoryGirl.create(:player) }
    kind do
      kinds = ["punt", "touchdown", "kickoff", "field-goal-is-good", "fumble",
        "interceptation"]
      kinds[rand(kinds.length)]
    end

    factory :move_with_comment do
      after(:create) do |move|
        move.comments << FactoryGirl.create(:comment,
          :author => move.match.channel.owner, :move => move)
      end
    end
  end
end
