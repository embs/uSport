require 'spec_helper'
require 'cancan/matchers'

describe 'Team ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team) }
  let(:team_owner) { FactoryGirl.create(:user) }
  let(:team_manager) { FactoryGirl.create(:user) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'user is not able to create a team' do
      subject.should_not be_able_to(:create, Team)
    end

    it 'user is not able to manage a team' do
      subject.should_not be_able_to(:manage, Team)
    end

    it 'user is able to see any team' do
      subject.should be_able_to(:show, Team)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'user is able to see any team' do
      subject.should be_able_to(:show, Team)
    end

    it 'user is able to create a team' do
      subject.should be_able_to(:create, Team)
    end

    it 'user is not able to manage the team' do
      subject.should_not be_able_to(:manage, team)
    end

    context 'the team owner' do
      subject { Ability.new(team_owner) }

      before do
        UserTeamAssociation.create(user: team_owner, team: team, role: :owner)
      end

      it 'is able to edit his team' do
        subject.should be_able_to(:edit, team)
      end

      it 'is able to manage (which includes deletetion of) his team' do
        subject.should be_able_to(:manage, team)
      end
    end

    context 'the team manager' do
      subject { Ability.new(team_manager) }

      before do
        UserTeamAssociation.create(user: team_manager, team: team, role: :manager)
      end

      it 'is able to edit the team' do
        subject.should be_able_to(:edit, team)
      end

      it 'is not able to manage (which includes deletetion of) the team' do
        subject.should_not be_able_to(:manage, team)
      end
    end
  end
end
