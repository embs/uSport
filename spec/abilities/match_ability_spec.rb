require 'spec_helper'
require 'cancan/matchers'

describe 'Match ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel) }
  let(:users_channel) { FactoryGirl.create(:channel, :owner => user) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'user is not able to create a match' do
      subject.should_not be_able_to(:create, Match)
    end

    it 'user is able to see any match' do
      subject.should be_able_to(:show, Match)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    context 'as channel owner' do
      it 'user is able to create a match for his channel' do
        subject.should be_able_to(:create, Match.new(:channel => users_channel))
      end
    end
  end
end
