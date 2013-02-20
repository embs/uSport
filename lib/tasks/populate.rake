# encoding: utf-8
task create_users: :environment do
  5.times { FactoryGirl.create :user }
end

task create_teams: :environment do
  FactoryGirl.create :team_with_players, name: 'Recife Mariners'
  FactoryGirl.create :team_with_players, name: 'Olinda Killers'
  FactoryGirl.create :team_with_players, name: 'João Pessoa Destroyers'
  FactoryGirl.create :team_with_players, name: 'Caruaru Carnicers'
  FactoryGirl.create :team_with_players, name: 'Petrolina Supplanters'
end

task create_channels: :environment do
  owner = User.first || FactoryGirl.create(:user)
  5.times { FactoryGirl.create(:channel, owner: owner) }
end

task create_matches: :environment do
  channel = Channel.first || FactoryGirl.create(:channel)
  5.times { FactoryGirl.create(:match, channel: channel) }
end

task create_moves: :environment do
  match = Match.first || FactoryGirl.create(:match)
  10.times { FactoryGirl.create(:move, match: match) }
end

task :create_all => [:environment, :create_users, :create_teams,
  :create_channels, :create_matches, :create_moves]
