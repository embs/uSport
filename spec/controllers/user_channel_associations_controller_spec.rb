require 'spec_helper'

describe UserChannelAssociationsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_channel_association) { FactoryGirl.create :user_channel_association,
    channel: user.channels.first }

  before do
    controller.stub(current_user: user)
  end

  describe 'DELETE destroy' do
    before do
      user_channel_association
      delete :destroy, id: user_channel_association, format: :js
    end

    it { assigns[:uca].should == user_channel_association }

    it { response.should be_success }

    it 'destroyes user channel association' do
      UserChannelAssociation.find_by_id(user_channel_association.id).should be_nil
    end

    it 'removes user from channel users' do
      user_channel_association.channel.users.should_not include(user_channel_association.user)
    end
  end
end
