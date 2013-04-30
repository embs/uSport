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

  factory :comment_move, class: Move do
    match { FactoryGirl.create(:match) }
    kind 'comment'
  end

  factory :time_move, class: Move do
    match { FactoryGirl.create(:match) }
    kind 'time'
  end

  factory :end_move, class: Move do
    match { FactoryGirl.create(:match) }
    kind 'end'
  end
end
