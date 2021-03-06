require 'spec_helper'
require 'cancan/matchers'

describe 'User ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to manage an user' do
      subject.should_not be_able_to(:manage, user)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'should be able to manage himself' do
      subject.should be_able_to(:manage, user)
    end

    it 'should not be able to manage another user' do
      subject.should_not be_able_to(:manage, another_user)
    end

    context 'an admin' do
      before { user.update_attribute(:role, :admin) }

      it 'can manage everything' do
        subject.should be_able_to :manage, :all
      end
    end
  end
end
