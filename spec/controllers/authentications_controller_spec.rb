require 'spec_helper'

describe AuthenticationsController do

  describe 'POST create' do
    before do
      set_omniauth()
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

    context 'when authentication does not exist' do
      it 'creates a new user' do
        expect {
          post :create
        }.to change(User, :count).by(1)
      end

      it 'signs user in' do
        post :create
        subject.current_user.should_not be_nil
      end
    end

    context 'when authentication does exist' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        Authentication.create(:user_id => user.id,
                              :uid => request.env['omniauth.auth']['uid'],
                              :provider => request.env['omniauth.auth']['provider'])
      end

      it 'does not create a new user' do
        expect {
          post :create
        }.to change(User, :count).by(0)
      end

      it 'signs user in' do
        post :create
        subject.current_user.should == user
      end
    end
  end
end
