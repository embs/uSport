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
    let(:move) { FactoryGirl.create(:move) }
    let(:users_move) { FactoryGirl.create(:move, :match => users_match) }
    subject { Ability.new(user) }

    it 'user is not able to create a move for a match in a channel he does not own' do
      subject.should_not be_able_to(:create, Move.new(:match => match))
    end

    it 'user is not able to manage a move for a match in a channel he does not own' do
      subject.should_not be_able_to(:manage, match)
    end

    context 'as channel owner' do
      it 'user is able to create a move for one of his channels matches' do
        subject.should be_able_to(:create, Move.new(:match => users_match))
      end

      it 'user is able to manage a move in one of his channels matches' do
        subject.should be_able_to(:manage, users_move)
      end
    end
  end
end
