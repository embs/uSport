# encoding: utf-8
task create_users: :environment do
  5.times { FactoryGirl.create :user }
end

task create_teams: :environment do
  sufix = ['Mariners', 'Pirates', 'Destroyers', 'Killers', 'Supplanters']
  5.times {
    FactoryGirl.create(:team_with_players,
      is_official: (rand(2) == 1),
      name: "#{Faker::Address.city} #{sufix[rand(5)]}"
      )
  }
end

task create_channels: :environment do
  owner = User.first || FactoryGirl.create(:user)
  5.times { FactoryGirl.create(:channel, owner: owner) }
end

task create_matches: :environment do
  channel = Channel.first || FactoryGirl.create(:channel)
  5.times { FactoryGirl.create(:match_with_teams, channel: channel) }
end

task create_moves: :environment do
  match = Match.first || FactoryGirl.create(:match)
  10.times do
    team = match.teams[rand(2)]
    FactoryGirl.create(:move, match: match, team: team,
      player: team.players[rand(team.players.length)])
  end
end

task :create_all => [:environment, :create_users, :create_teams,
  :create_channels, :create_matches, :create_moves]
