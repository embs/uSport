require 'spec_helper'
require 'cancan/matchers'

describe 'Channel ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'user is not able to manage a channel' do
      subject.should_not be_able_to(:manage, channel)
    end

    it 'user is not able to create a channel' do
      subject.should_not be_able_to(:create, channel)
    end

    it 'user is able to see any channel' do
      subject.should be_able_to(:show, Channel)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'user is not able to manage a channel he does not own' do
      subject.should_not be_able_to(:manage, channel)
    end

    it 'user is able to create a channel' do
      subject.should be_able_to(:create, Channel)
    end

    context 'as channel owner' do
      let(:users_channel) { FactoryGirl.create(:channel, :owner => user) }

      it 'user is able to manage his channel' do
        subject.should be_able_to(:manage, users_channel)
      end
    end
  end
end
