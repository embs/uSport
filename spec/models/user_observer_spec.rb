require 'spec_helper'

describe UserObserver do

  describe 'after create' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'creates a channel' do
      Channel.last.should_not be_nil
    end

    it 'creates a channel with same name as user username' do
      Channel.last.name.should == @user.username
    end

    it 'creates a channel with user as its owner' do
      Channel.last.owner.should == @user
    end

    it 'associates user and channel' do
      @user.channels.should include(Channel.last)
    end
  end
end
