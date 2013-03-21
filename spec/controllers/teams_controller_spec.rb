# encoding: utf-8
require 'spec_helper'

describe TeamsController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET index' do
    before do
      get :index
    end

    it { assigns[:teams].should_not be_nil }

    it { response.should be_success }

    it { should render_template(:index) }
  end

  describe 'GET show' do
    let(:team) { FactoryGirl.create(:team) }

    before do
      get :show, :id => team.id
    end

    it { assigns[:team].should == Team.find(team.id) }

    it { response.should be_success }

    it { should render_template(:show) }
  end

  describe 'GET new' do
    context 'when logged' do
      before do
        controller.stub(:current_user => user)
        get :new, :locale => 'pt-BR'
      end

      it { assigns[:team].should_not be_nil } #FIXME verificar o problema com Team.new

      it { response.should be_success }

      it { should render_template(:new) }
    end # context 'when logged'

    context 'when not logged' do
      before do
        get :new, :locale => 'pt-BR'
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end

  describe 'POST create' do
    let(:common_params) { { :locale => 'pt-BR' } }
    let(:valid_params) do
      { team: {
        name: 'USport Team', sport_type: 'football', abbreviation: 'US'
      } }.merge(common_params)
    end

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
      end

      context 'with valid params' do
        before do
          post :create, valid_params
        end

        it 'creates team' do
          Team.last.name.should == 'USport Team'
        end

        it { assigns[:team].should_not be_nil }

        it { should set_the_flash[:notice].to('Time criado!') }

        it { response.should be_redirect }

        it { should redirect_to(teams_path) }
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
    end # context 'when logged'

    context 'when not logged' do
      before do
        post :create, valid_params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end # describe 'POST create'

  describe 'GET edit' do
    let(:team) { FactoryGirl.create(:team) }

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
        get :edit, :locale => 'pt-BR', :id => team.id
      end

      it { assigns[:team].should_not be_nil }

      it { response.should be_success }

      it { should render_template(:edit) }
    end

    context 'when not logged' do
      before do
        get :edit, :locale => 'pt-BR', :id => team.id
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end
  end

  describe 'POST update' do
    let(:team) { FactoryGirl.create(:team) }
    let(:common_params) { { :locale => 'pt-BR' } }
    let(:valid_params) do
      {
        :team => { :name => 'USport Team', :sport_type => 'football' }, :id => team.id
      }.merge(common_params)
    end

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
      end

      context 'with valid params' do
        before do
          post :update, valid_params
        end

        it { should set_the_flash[:notice].to('Time atualizado!') }

        it { response.should be_redirect }

        it { should redirect_to(root_path) }
      end # context 'with valid params'

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
      end # context 'with invalid params'
    end # context 'when logged'

    context 'when not logged' do
      before do
        post :update, valid_params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end

  describe 'DELETE destroy' do
    let(:team) { FactoryGirl.create(:team) }

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
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
    end # context 'when logged'

    context 'when not logged' do
      before do
        post :destroy, :locale => 'pt-BR', :id => team.id
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end
end
