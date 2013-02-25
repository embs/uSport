require 'spec_helper'
require 'cancan/matchers'

describe 'Move ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel) }
  let(:users_channel) { FactoryGirl.create(:channel, :owner => user) }
  let(:match) { FactoryGirl.create(:match) }
  let(:users_match) { FactoryGirl.create(:match, :channel => users_channel) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'user is not able to create a move' do
      subject.should_not be_able_to(:create, Move)
    end

    it 'user is able to see any move' do
      subject.should be_able_to(:show, Move)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'user is not able to create a move for a match in a channel he does not own' do
      subject.should_not be_able_to(:create, Move.new(:match => match))
    end

    context 'as channel owner' do
      it 'user is able to create a move one of his channels match' do
        subject.should be_able_to(:create, Move.new(:match => users_match))
      end
    end
  end
end
