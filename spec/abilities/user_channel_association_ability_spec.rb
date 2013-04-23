require 'spec_helper'
require 'cancan/matchers'

describe 'UserChannelAssociationAbility ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel, owner: user) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:uca) { FactoryGirl.build(:user_channel_association, channel: channel) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to create user chanel association' do
      subject.should_not be_able_to(:create, UserChannelAssociation)
    end

    it 'should not be able to manage user channel association' do
      subject.should_not be_able_to(:manage, uca)
    end

    it 'should be able to see user channel association' do
      subject.should be_able_to(:show, UserChannelAssociation)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    context 'as the channels owner' do
      it 'should be able to create user channel association' do
        subject.should be_able_to(:create, uca)
      end

      it 'should be able to manage user channel association' do
        subject.should be_able_to(:manage, uca)
      end

      it 'should not be able to manage his own association to his channel' do
        uca = UserChannelAssociation.create(user: user, channel: channel)
        subject.should_not be_able_to(:manage, uca)
      end
    end # context 'as the channels owner'

    context 'as an user other than the channels owner' do
      subject { Ability.new(another_user) }

      it 'should be able to see user channel association' do
        subject.should be_able_to(:show, uca)
      end

      it 'should not be able to create user channel association' do
        subject.should_not be_able_to(:create, uca)
      end

      it 'should not be able to manage user channel association' do
        subject.should_not be_able_to(:manage, uca)
      end
    end # context 'as an user other than the channels owner'
  end
end
