require 'spec_helper'

describe Match do
  # Associações
  it { should have_many :moves }
  it { should belong_to :channel }
  it { should have_and_belong_to_many :teams }

  # Validações
  it { should validate_presence_of :date }
  it { should validate_presence_of :name }
  it { should validate_presence_of :channel }

  # Assegura que a criação de novas partidas com times já associados a partidas
  # previamente existentes não desassocia times das partidas antigas - issue #1
  context 'when creating multiple matches with the same teams' do
    let(:team1) { FactoryGirl.create(:team, name: 'Recife') }
    let(:team2) { FactoryGirl.create(:team, name: 'Olinda') }

    before do
      @previous_match = FactoryGirl.create(:match)
      @previous_match.teams << [team1, team2]
      @new_match = FactoryGirl.create(:match)
      @new_match.teams << [team1, team2]
    end

    it 'does not remove teams from previous matches' do
      @previous_match.teams.should include team1, team2
    end

    it 'associates the new match and the teams' do
      @new_match.teams.should include team1, team2
    end
  end
end
