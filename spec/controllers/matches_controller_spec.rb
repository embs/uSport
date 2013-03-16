# encoding: utf-8
require 'spec_helper'

describe MatchesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:channels_owner) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel, :owner => channels_owner) }

  describe 'GET new' do
    context 'when logged as channel owner' do
      before do
        controller.stub(:current_user => channels_owner)
        get :new, :locale => 'pt-BR', :user_id => user.id, :channel_id => channel.id
      end

      it { assigns(:match).should_not be_nil } #FIXME Verificar o problema com Match.new

      it { assigns[:teams].should == Team.all }

      it { should render_template(:new) }

      it { response.should be_success }
    end # context 'when logged'

    context 'when logged as an user wich does not own the channel' do
      before do
        controller.stub(:current_user => user)
        get :new, :locale => 'pt-BR', :user_id => user.id, :channel_id => channel.id
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end

    context 'when not logged' do
      before do
        get :new, :locale => 'pt-BR', :user_id => user.id, :channel_id => channel.id
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end
  end

  describe 'POST create' do
    let(:team1) { FactoryGirl.create(:team) }
    let(:team2) { FactoryGirl.create(:team) }
    let(:match_date) { { :day => 16, :month => 1, :year => 2013, :hour => 20,
      :min => 0 } }
    let(:valid_params) do
      {
        :user_id => channels_owner.id, :channel_id => channel.id,
        :football_match => {
          :name => 'Nova Partida', :type => 'FootballMatch', :date => '29/02/2013',
          :channel_id => channel.id, :teams_ids => [team1.id, team2.id],
          "date(1i)" => match_date[:year], "date(2i)" => match_date[:month],
          "date(3i)" => match_date[:day], "date(4i)" => match_date[:hour],
          "date(5i)" => match_date[:min]
        }
      }
    end

    context 'when logged as channel owner' do
      before do
        controller.stub(:current_user => channels_owner)
      end

      context 'with valid fields' do

        before do
          post :create, valid_params
        end

        it 'creates new match' do
          Match.last.name.should == valid_params[:football_match][:name]
        end

        it 'associates team1' do
          Match.last.teams.should include(team1)
        end

        it 'associates team2' do
          Match.last.teams.should include(team2)
        end

        it 'sets match date and time properly' do
          m = Match.last
          m.date.year.should == match_date[:year]
          m.date.month.should == match_date[:month]
          m.date.day.should == match_date[:day]
          m.date.hour.should == match_date[:hour]
          m.date.min.should == match_date[:min]
        end

        it { should set_the_flash[:notice].to('Partida criada!')}

        it { should redirect_to match_path(Match.last) }

        it { response.should be_redirect }
      end # context 'with valid fields'

      context 'trying to create a match without associated teams' do
        before do
          valid_params[:football_match].delete(:teams_ids)
          post :create, valid_params
        end

        it { should render_template(:new) }

        it 'does not create match' do
          Match.last.should be_nil
        end

        it { should set_the_flash[:alert].to('Ops! Não foi possível criar a partida.').now }
      end

      context 'with invalid fields' do
        let(:invalid_params) do
          {
            :user_id => channels_owner.id, :channel_id => channel.id,
            :football_match => {
              :name => '', :type => 'FootballMatch', :date => '29/02/2013',
              :channel_id => channel.id, :teams_ids => [team1.id, team2.id]
            }
          }
        end

        before do
          post :create, invalid_params
        end

        it { should render_template(:new) }

        it 'does not create match' do
          Match.last.should be_nil
        end

        it { should set_the_flash[:alert].to('Ops! Não foi possível criar a partida.').now }
      end # context 'with invalid fields'
    end # context 'when logged as channel owner'

    context 'when logged as an user wich does not own the channel' do
      before do
        controller.stub(:current_user => user)
        post :create, valid_params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when logged as an user wich does not own the channel'

    context 'when not logged' do
      before do
        post :create, valid_params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end
end
