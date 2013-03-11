require 'spec_helper'
require 'cancan/matchers'

describe 'UserFavoriteChannel ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:favorite) do
    FactoryGirl.create(:user_favorite_channel, user: user, channel: channel)
  end

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to favorite a channel' do
      subject.should_not be_able_to(:create, UserFavoriteChannel)
    end

    it 'should not be able to manage user favorite channel' do
      subject.should_not be_able_to(:manage, favorite)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'should be able to favorite channel' do
      subject.should be_able_to(:create, UserFavoriteChannel)
    end

    it 'should be able to manage his favorite channel' do
      subject.should be_able_to(:manage, favorite)
    end

    it 'should not be able to manage other users favorite channel' do
      other_favorite = FactoryGirl.create(:user_favorite_channel,
        user: another_user, channel: channel)
      subject.should_not be_able_to(:manage, other_favorite)
    end
  end
end
