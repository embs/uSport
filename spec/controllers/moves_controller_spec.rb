require 'spec_helper'

describe MovesController do

  describe 'GET index' do
    let(:match) { FactoryGirl.create(:match) }

    before do
      10.times do
        match.moves << FactoryGirl.create(:move, :match => match)
      end
      get :index, :user_id => match.channel.owner.id, :channel_id => match.channel.id,
        :match_id => match.id
    end

    it "paginates moves" do
      assigns[:moves].should == match.moves.first(10)
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

      it { response.should redirect_to(root_path) }

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
    let(:move) { FactoryGirl.create(:move, :kind => 'touchdown') }
    let(:player) { FactoryGirl.create(:player) }
    let(:params) do
      {
        :user_id => move.match.channel.owner.id,
        :channel_id => move.match.channel.id, :match_id => move.match.id,
        :id => move.id
      }.merge(move: { kind: 'punt', player: "##{player.number} #{player.first_name}",
              team: player.team })
    end

    context 'when not logged' do
      before do
        post :update, params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end

    context 'when logged' do
      context 'as channels owner' do
        before do
          controller.stub(:current_user => move.match.channel.owner)
          post :update, params
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
      end

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

      it { response.should redirect_to(root_path) }

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
