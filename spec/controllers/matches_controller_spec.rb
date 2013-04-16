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

      it { response.should redirect_to(new_user_session_path) }

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
          "date(3i)" => match_date[:day] },
          date: { :'time(4i)' => match_date[:hour], :'time(5i)' => match_date[:min] }
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

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end # describe 'POST create' do

  describe 'GET edit' do
    let(:match) { FactoryGirl.create(:football_match, channel: channel) }

    before do
      controller.stub(current_user: channels_owner)
      get :edit, id: match
    end

    it { response.should be_success }

    it { should render_template(:edit) }

    it { assigns[:match].should == match }
  end # describe 'GET edit'

  describe 'POST update' do
    let(:match) { FactoryGirl.create(:football_match, channel: channel) }
    let(:new_team1) { FactoryGirl.create(:team) }
    let(:new_team2) { FactoryGirl.create(:team) }

    before do
      controller.stub(current_user: channels_owner)
      post :update, { id: match, football_match: {
        name: 'Novo nome pra esse match',
        teams_ids: [new_team1.id, new_team2.id]
      } }
    end

    it { response.should be_redirect }

    it { should set_the_flash[:notice].to('Partida atualizada!') }

    it 'updates match name' do
      Match.last.name.should == 'Novo nome pra esse match'
    end

    it { should redirect_to(match_path(match)) }

    it 'updates teams' do
      match = Match.last
      match.teams.should include(new_team1)
      match.teams.should include(new_team2)
    end
  end

  describe 'POST auth' do
    let(:match) { FactoryGirl.create :match }

    before do
      post :auth, channel_name: "presence-match-#{match.id}",
        socket_id: '123.45678', user_id: SecureRandom.hex(4)
    end

    it { response.should be_success }

    it 'should retrieve an auth key' do
      auth_response = JSON.parse(response.body)
      auth_response.should have_key('auth')
    end
  end
end
