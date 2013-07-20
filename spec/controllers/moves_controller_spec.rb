# encoding: utf-8
require 'spec_helper'

describe MovesController do

  describe 'GET index' do
    let(:match) { FactoryGirl.create(:match) }

    before do
      10.times do
        match.moves << FactoryGirl.create(:move, :match => match)
      end
      get :index, :user_id => match.channel.owner.id, :channel_id => match.channel.id,
        :match_id => match.id, format: :js
    end

    it "paginates moves" do
      assigns[:moves].should == match.moves.first(10)
    end

    it 'responds with js' do
      response.content_type.should == Mime::JS
    end
  end

  describe 'GET new' do
    let(:user) { FactoryGirl.create(:user) }
    let(:channel) { FactoryGirl.create(:channel, owner: user) }
    let(:match) { FactoryGirl.create(:match, channel: channel) }

    before do
      controller.stub(current_user: user)
      get :new, { user_id: match.channel.owner, channel_id: match.channel,
        match_id: match }
    end

    it { assigns[:move].should_not be_nil }

    it { assigns[:kinds].should_not be_nil }

    it { assigns[:minutes].should_not be_nil }

    it { assigns[:yards].should_not be_nil }

    it { assigns[:match].should_not be_nil }

    it { response.should be_success }

    it { should render_template(:new) }
  end

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:channel) { FactoryGirl.create(:channel, owner: user) }
    let(:match) { FactoryGirl.create(:match, channel: channel) }
    let(:team) { FactoryGirl.create(:team) }
    let(:player) { FactoryGirl.create(:player, first_name: 'Jogador', team: team) }

    context 'a touchdown' do
      before do
        controller.stub(current_user: user)
        post :create, user_id: match.channel.owner, channel_id: match.channel,
          match_id: match, move: { player: "##{player.number} #{player.first_name}",
            team: team.id, kind: 'touchdown', yards: -50
          }, format: :js
      end

      it 'creates new move' do
        Move.last.should_not be_nil
      end

      it 'creates move with negative yards' do
        Move.last.yards.should < 0
      end
    end # context 'a touchdown'

    context 'a touchdown without player' do
      before do
        controller.stub(current_user: user)
        post :create, user_id: match.channel.owner, channel_id: match.channel,
          match_id: match, move: {
            team: team.id, kind: 'touchdown', yards: -50
          }, format: :js
      end

      it 'creates new move' do
        Move.last.should_not be_nil
      end
    end # context 'a touchdown without player'

    context 'a comment' do
      before do
        controller.stub(current_user: user)
        post :create, user_id: match.channel.owner, channel_id: match.channel,
          match_id: match, move: { player: '',
            team: team.id, kind: 'comment', yards: '', quarter: '0',
            description: 'Esta é uma jogada de comentário'
          }, format: :js
      end

      it 'creates new move' do
        Move.last.should_not be_nil
      end

      it 'creates move with comment kind' do
        Move.last.kind.should == 'comment'
      end

      it 'creates move with negative yards' do
        Move.last.description.should == 'Esta é uma jogada de comentário'
      end
    end # context 'a comment'

    context 'a time request' do
      before do
        controller.stub(current_user: user)
        post :create, user_id: match.channel.owner, channel_id: match.channel,
          match_id: match, move: { player: '',
            team: team.id, kind: 'time', yards: '', quarter: '0',
            description: 'Esta é uma jogada de tempo'
          }, format: :js
      end

      it 'creates new move' do
        Move.last.should_not be_nil
      end

      it 'creates move with comment kind' do
        Move.last.kind.should == 'time'
      end

      it 'creates move with negative yards' do
        Move.last.description.should == 'Esta é uma jogada de tempo'
      end
    end
  end # describe 'POST create'

  describe 'GET edit' do
    let(:move) { FactoryGirl.create(:move) }
    let(:params) do
      {
        :user_id => move.match.channel.owner.id,
        :channel_id => move.match.channel.id, :match_id => move.match.id,
        :id => move.id
      }
    end

    context 'when not logged' do
      before do
        get :edit, params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'

    context 'when logged' do
      context 'as channels owner' do
        before do
          controller.stub(:current_user => move.match.channel.owner)
          get :edit, params
        end

        it { response.should be_success }

        it { assigns[:move].should == move }

        it { should render_template(:edit) }
      end

      context 'as an user other than the channels owner' do
        before do
          controller.stub(:current_user => FactoryGirl.create(:user) )
          get :edit, params
        end

        it { response.should redirect_to(root_path) }

        it { should set_the_flash[:alert] }
      end
    end # context 'when logged'
  end # describe 'GET edit'

  describe 'POST update' do
    let(:move) { FactoryGirl.create(:move, kind: 'touchdown') }
    let(:player) { FactoryGirl.create(:player) }
    let(:params) { { match_id: move.match.id, id: move.id } }

    context 'when not logged' do
      before do
        post :update, params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end

    context 'when logged' do

      context 'as channels owner' do
        before do
          controller.stub(current_user: move.match.channel.owner)
        end

        context 'updating a common move' do
          before do
            post :update, params.merge(move: {
              kind: 'punt', player: "##{player.number} #{player.first_name}",
              team: player.team.id
            })
          end

          it 'updates the kind of the move' do
            Move.find(move.id).kind.should == 'punt'
          end

          it 'updates the player of the move' do
            Move.find(move.id).player.should == player
          end

          it { response.should be_redirect }

          it { assigns[:move].should == move }

          it { should set_the_flash[:notice].to('Jogada atualizada!') }
        end # context 'updating a common move'

        context 'updating a comment move' do
          let(:move) { FactoryGirl.create(:comment_move) }

          before do
            post :update, params.merge(move: { description: 'Jogo emocionante!' })
          end

          it 'updates move description' do
            Move.find(move.id).description.should == 'Jogo emocionante!'
          end

          it { response.should be_redirect }

          it { assigns[:move].should == move }

          it { should set_the_flash[:notice].to('Jogada atualizada!') }
        end # context 'updating a comment move'

        context 'updating a time move' do
          let(:move) { FactoryGirl.create(:time_move) }
          let(:another_team) { FactoryGirl.create(:team) }

          before do
            post :update, params.merge(move: { team: another_team.id })
          end

          it 'updates move team' do
            Move.find(move.id).team.should == another_team
          end

          it { response.should be_redirect }

          it { assigns[:move].should == move }

          it { should set_the_flash[:notice].to('Jogada atualizada!') }
        end # context 'updating a time move'

        context 'updating an end move' do
          let(:move) { FactoryGirl.create(:end_move) }

          before do
            post :update, params.merge(move: { description: 'Jogo emocionante!' })
          end

          it 'updates move description' do
            Move.find(move.id).description.should == 'Jogo emocionante!'
          end

          it { response.should be_redirect }

          it { assigns[:move].should == move }

          it { should set_the_flash[:notice].to('Jogada atualizada!') }
        end # context 'updating an end move'
      end # context 'as channels owner'

      context 'as an user other than the channels owner' do
        before do
          controller.stub(:current_user => FactoryGirl.create(:user) )
          post :update, params
        end

        it { response.should redirect_to(root_path) }

        it { should set_the_flash[:alert] }
      end
    end # context 'when logged'
  end # describe 'POST update'

  describe 'POST destroy' do
    let(:move) { FactoryGirl.create(:move, :kind => 'touchdown') }
    let(:params) do
      {
        :user_id => move.match.channel.owner.id,
        :channel_id => move.match.channel.id, :match_id => move.match.id,
        :id => move.id
      }
    end

    context 'when not logged' do
      before do
        post :destroy, params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }

      it 'does not destroy the move' do
          expect {
            Move.find(move.id)
          }.to_not raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when logged' do
      context 'as channels owner' do
        before do
          controller.stub(:current_user => move.match.channel.owner)
        end

        context 'via html' do
          before do
            post :destroy, params
          end

          it 'destroys the move' do
            expect {
              Move.find(move.id)
            }.to raise_error(ActiveRecord::RecordNotFound)
          end

          it { response.should be_redirect }

          it { assigns[:move].should == move }

          it { should set_the_flash[:notice].to('A jogada foi removida.') }
        end

        context 'via js' do
          before do
            post :destroy, params.merge(format: :js)
          end

          it 'destroys the move' do
            expect {
              Move.find(move.id)
            }.to raise_error(ActiveRecord::RecordNotFound)
          end

          it { response.should be_success }

          it { assigns[:move].should == move }

          it { should_not set_the_flash[:notice].to('A jogada foi removida.') }

          it { should render_template(:destroy) }
        end
      end

      context 'as an user other than the channels owner' do
        before do
          controller.stub(:current_user => FactoryGirl.create(:user) )
          post :destroy, params
        end

        it { response.should redirect_to(root_path) }

        it { should set_the_flash[:alert] }

        it 'does not destroy the move' do
            expect {
              Move.find(move.id)
            }.to_not raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end # context 'when logged'
  end # describe 'POST destroy'
end
