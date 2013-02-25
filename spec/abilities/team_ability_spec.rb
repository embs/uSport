require 'spec_helper'
require 'cancan/matchers'

describe 'Team ability' do
  let(:user) { FactoryGirl.create(:user) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'user is not able to create a team' do
      subject.should_not be_able_to(:create, Team)
    end

    it 'user is able to see any team' do
      subject.should be_able_to(:show, Team)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'user is able to create a team' do
      subject.should be_able_to(:create, Team)
    end
  end
end
