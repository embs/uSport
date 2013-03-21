# encoding: utf-8
require 'spec_helper'

describe PlayersController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET new' do

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
        get :new
      end

      it { should render_template(:new) }

      it { assigns[:player].should_not be_nil }
    end

    context 'when not logged' do
      before do
        get :new
      end

      it { response.should be_redirect }

      it { should set_the_flash[:alert] }

      it { should_not render_template(:new) }
    end
  end

  describe 'POST create' do
    let(:team) { FactoryGirl.create(:team) }
    let(:valid_params) do
      {
        :player => { :first_name => 'Antonio', :last_name => 'Nunes',
          :team_id => team.id, :number => (rand(100)+1) }
      }
    end

    context 'when logged' do
      let(:user) { FactoryGirl.create(:user) }

      before { controller.stub(:current_user => user) }

      context 'with valid parameters' do
        before do
          post :create, valid_params
        end

        it 'creates new player' do
          Player.last.first_name.should == valid_params[:player][:first_name]
          Player.last.last_name.should == valid_params[:player][:last_name]
        end

        it { response.should be_redirect }

        it { response.should redirect_to(teams_path) }

        it { should set_the_flash[:notice].to("Jogador criado!") }
      end # context 'with valid parameters'

      context 'with invalid parameters' do
        let(:invalid_params) do
          {
            :player => { :first_name => '', :last_name => 'Nunes' }
          }
        end

        before do
          post :create, invalid_params
        end

        it 'should not create new player' do
          Player.last.should be_nil
        end

        it { should render_template(:new) }

        it { should set_the_flash[:alert].to('Ops! Não foi possível criar o jogador.') }
      end # context 'with invalid parameters'
    end # context 'when logged'

    context 'when not logged' do
      before do
        post :create, valid_params
      end

      it { should_not render_template(:new) }

      it { should set_the_flash[:alert] }

      it { response.should be_redirect }
    end # context 'when not logged'
  end # describe 'POST create'

  describe 'GET edit' do
    let(:player) { FactoryGirl.create :player }

    before do
      controller.stub(current_user: user)
      get :edit, id: player
    end

    it { response.should be_success }

    it { should render_template(:edit) }

    it { assigns[:player].should == player }
  end # describe 'GET edit'

  describe 'POST update' do
    let(:player) { FactoryGirl.create :player, { first_name: 'Anakin', last_name: 'Skywalker' } }

    before do
      controller.stub(current_user: user)
      post :update, id: player, player: { first_name: 'Darth', last_name: 'Vader' }
    end

    it 'updates players first name' do
      Player.last.first_name.should == 'Darth'
    end

    it 'updates players last name' do
      Player.last.last_name.should == 'Vader'
    end

    it { should set_the_flash[:notice] }

    it { response.should be_redirect }

    it { should redirect_to(player_path(player)) }
  end # describe 'POST update'

  describe 'DELETE destroy' do
    let(:player) { FactoryGirl.create :player }

    before do
      controller.stub(current_user: user)
      delete :destroy, id: player
    end

    it 'destroys player' do
      Player.last.should be_nil
    end

    it { response.should be_redirect }

    it { response.should redirect_to(teams_path) }

    it { should set_the_flash[:notice] }
  end # describe 'DELETE destroy'
end
