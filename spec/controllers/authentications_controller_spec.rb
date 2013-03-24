# encoding: utf-8
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

      it 'creates a new authentication' do
        expect {
          post :create
        }.to change(Authentication, :count).by(1)
      end

      it 'signs user in' do
        post :create
        subject.current_user.should_not be_nil
      end

      it 'sets the flash[:notice]' do
        post :create
        should set_the_flash[:notice].to("Você entrou com a sua conta do Facebook.")
      end

      it 'redirects the user' do
        post :create
        response.should be_redirect
      end

      context 'but there is already an account with associated email' do
        before do
          FactoryGirl.create(:user, email: request.env['omniauth.auth']['info']['email'])
        end

        it 'does not create a new user' do
          expect {
            post :create
          }.to change(User, :count).by(0)
        end

        it 'creates a new authentication' do
          expect {
            post :create
          }.to change(Authentication, :count).by(1)
        end

        it 'logs user in' do
          post :create
          controller.current_user.should_not be_nil
        end
      end # context 'but there is already an account with associated email'
    end # context 'when authentication does not exist'

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
    end # context 'when authentication does exist'
  end
end
