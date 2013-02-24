# encoding: utf-8
require 'spec_helper'

describe TeamsController do

  describe 'GET new' do
    before do
      get :new, :locale => 'pt-BR'
    end

    it { assigns[:team].should_not be_nil } #FIXME verificar o problema com Team.new

    it { response.should be_success }

    it { should render_template(:new) }
  end

  describe 'POST create' do
    let(:common_params) { { :locale => 'pt-BR' } }

    context 'with valid params' do
      let(:valid_params) do
        {
          :team => { :name => 'USport Team', :sport_type => 'football' }
        }.merge(common_params)
      end

      before do
        post :create, valid_params
      end

      it 'creates team' do
        Team.last.name.should == 'USport Team'
      end

      it { assigns[:team].should_not be_nil }

      it { should set_the_flash[:notice].to('Time criado!') }

      it { response.should be_redirect }

      it { should redirect_to(root_path) }
    end # context 'with valid params'

    context 'with invalid params' do
      let(:invalid_params) do
        {
          :team => { :name => '', :sport_type => 'football' }
        }.merge(common_params)
      end

      before do
        post :create, invalid_params
      end

      it 'does not create team' do
        Team.last.should be_nil
      end

      it { assigns[:team].should_not be_nil }

      it { should set_the_flash[:error].to('Ops! Não foi possível criar o time.').now }

      it { response.should be_success }

      it { should render_template(:edit) }
    end # context 'with invalid params'
  end # describe 'POST create'

  describe 'GET edit' do
    let(:team) { FactoryGirl.create(:team) }

    before do
      get :edit, :locale => 'pt-BR', :id => team.id
    end

    it { assigns[:team].should_not be_nil }

    it { response.should be_success }

    it { should render_template(:edit) }
  end

  describe 'POST update' do
    let(:team) { FactoryGirl.create(:team) }
    let(:common_params) { { :locale => 'pt-BR' } }

    context 'with valid params' do
      let(:valid_params) do
        {
          :team => { :name => 'USport Team', :sport_type => 'football' },
          :id => team.id
        }.merge(common_params)
      end

      before do
        post :update, valid_params
      end

      it { should set_the_flash[:notice].to('Time atualizado!') }

      it { response.should be_redirect }

      it { should redirect_to(root_path) }
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          :team => { :name => '', :sport_type => 'football' },
          :id => team.id
        }.merge(common_params)
      end

      before do
        post :update, invalid_params
      end

      it { should set_the_flash[:error].to('Ops! Não foi possível atualizar o time.').now }

      it { response.should be_success }

      it { should render_template(:edit) }
    end
  end

  describe 'DELETE destroy' do
    let(:team) { FactoryGirl.create(:team) }

    before do
      post :destroy, :locale => 'pt-BR', :id => team.id
    end

    it 'destroys the team' do
      expect {
        Team.find(team.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it { should set_the_flash[:notice].to('Time removido!') }

    it { response.should be_redirect }

    it { should redirect_to(root_path) }
  end
end
