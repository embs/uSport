require 'spec_helper'

describe FavoriteChannelsController do
  let(:user) { FactoryGirl.create :user }
  let(:channel) { FactoryGirl.create :channel }

  before do
    user.favorite_channels << FactoryGirl.create(:channel)
  end

  describe 'GET index' do
    before do
      get :index, user_id: user
    end

    it { assigns[:favorites].should == user.favorite_channels }

    it { assigns[:user].should == user }

    it { response.should be_success }

    it { should render_template(:index) }
  end # describe 'GET index'

  describe 'POST create' do
    before do
      controller.stub(current_user: user)
      post :create, user_id: user, channel_id: channel
    end

    it 'creates user channel favorite' do
      UserFavoriteChannel.find_by_user_id_and_channel_id(user, channel).should_not be_nil
    end

    it 'creates favorite for user' do
      user.favorite_channels.should include(channel)
    end

    it 'creates favorited for channel' do
      channel.favorited_users.should include(user)
    end

    it { response.should be_redirect }

    it { should set_the_flash[:notice] }
  end # describe 'POST create'

  describe 'DELETE destroy' do
    let(:user_favorite_channel) { FactoryGirl.create(:user_favorite_channel,
      user: user, channel: channel) }

    before do
      controller.stub(current_user: user)
      delete :destroy, user_id: user, channel_id: channel, id: user_favorite_channel
    end

    it 'removes user channel favorite' do
      UserFavoriteChannel.find_by_user_id_and_channel_id(user, channel).should be_nil
    end

    it 'removes favorite for user' do
      user.favorite_channels.should_not include(channel)
    end

    it 'removes favorited for channel' do
      channel.favorited_users.should_not include(user)
    end

    it { response.should be_redirect }

    it { should set_the_flash[:notice] }
  end # describe 'DELETE destroy'
end
