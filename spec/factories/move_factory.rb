FactoryGirl.define do
  factory :move do
    match { FactoryGirl.create(:match) }
    kind do
      kinds = ["punt", "touchdown", "kickoff", "field-goal-is-good", "fumble",
        "interceptation"]
      kinds[rand(kinds.length)]
    end
  end
end
