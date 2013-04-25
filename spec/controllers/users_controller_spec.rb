require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET index' do
  end

  describe 'GET show' do
    before do
      get :show, id: user
    end

    it { assigns[:user].should == user }

    it { response.should be_redirect }

    it { should set_the_flash }

    it { should redirect_to(root_path) }
  end

  describe 'GET edit' do
    before do
      controller.stub(:current_user => user)
      get :edit, :locale => 'pt-BR', :id => user.id
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns user' do
      assigns[:user].should == user
    end
  end

  describe 'POST update' do
    let(:params) do
      { user: { first_name: 'Darth' }, id: user.id }
    end

    context 'when logged as account owner' do
      before do
        controller.stub(current_user: user)
      end

      context 'with valid fields' do
        before do
          post :update, params
        end

        it 'updates user' do
          u = User.find(user.id) # Carrega o usuário mais recente
          params[:user].each do |attr_name, attr_value|
            u.send(attr_name).should == attr_value
          end
        end

        it { should set_the_flash.to("Sua conta foi atualizada!") }
      end # context 'with valid fields'

      context 'with invalid fields' do
        before do
          post :update, params.merge(:user => { :first_name => '' })
        end

        it 'does not update user' do
          u = User.find(user.id) # Carrega o usuário mais recente
          u.should == user
        end

        it { should set_the_flash.to("Ops! Verifique os campos e tente novamente.").now }
      end # context 'with invalid fields'
    end

    context 'when logged as user which does not own the account' do
      let(:another_user) { FactoryGirl.create(:user) }

      before do
        controller.stub(:current_user => another_user)
        post :update, params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end

    context 'when not logged' do
      before do
        post :update, params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end
  end
end
