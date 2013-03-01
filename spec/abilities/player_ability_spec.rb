require 'spec_helper'
require 'cancan/matchers'

describe 'Player ability' do

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'user is not able to create a player' do
      subject.should_not be_able_to(:create, Player)
    end

    it 'user is able to see any player' do
      subject.should be_able_to(:show, Player)
    end

    it 'user is not able to manage any player' do
      subject.should_not be_able_to(:manage, Player)
    end
  end

  context 'when logged' do
    let(:user) { FactoryGirl.create(:user) }
    subject { Ability.new(user) }

    it 'user is able to create a player' do
      subject.should be_able_to(:create, Player)
    end

    it 'user is able to manage any player' do
      subject.should be_able_to(:manage, Player)
    end

    it 'user is able to see any player' do
      subject.should be_able_to(:show, Player)
    end
  end
end
