require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET index' do
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
    context 'with valid fields' do
      let(:params) do
        { :user => { :first_name => 'Darth' }, :locale => 'pt-BR', :id => user.id }
      end

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
      let(:params) do
        { :user => { :first_name => '' }, :locale => 'pt-BR', :id => user.id }
      end

      before do
        post :update, params
      end

      it 'does not update user' do
        u = User.find(user.id) # Carrega o usuário mais recente
        u.should == user
      end

      it { should set_the_flash.to("Ops! Verifique os campos e tente novamente.").now }
    end # context 'with invalid fields'
  end
end
