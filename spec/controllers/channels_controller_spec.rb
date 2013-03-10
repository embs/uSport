# encoding: utf-8
require 'spec_helper'

describe ChannelsController do

  describe 'GET index' do

    context 'for specific user channels' do
      let(:user) { FactoryGirl.create :user }

      before do
        FactoryGirl.create(:channel) # canal de outro usuário
        user.channels << FactoryGirl.create(:channel, owner: user)
        get :index, user_id: user.id
      end

      it { assigns[:channels].should == user.channels }

      it { response.should be_success }

      it { should render_template(:index) }
    end # context 'for specific user channels'

    context 'for all channels' do
      before do
        get :index
      end

      it { response.should be_success }

      it { should render_template(:index) }

      it { assigns[:channels] = Channel.all }
    end # context 'for all channels'
  end # describe 'GET index'

  describe 'GET show' do
    let(:channel) { FactoryGirl.create :channel }

    before do
      get :show, :locale => 'pt-BR', :id => channel.id, :user_id => channel.owner.id
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns channel' do
      assigns[:channel] = channel
    end
  end # describe 'GET show'

  describe 'GET new' do
    let(:user) { FactoryGirl.create(:user) }

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
        get :new, :locale => 'pt-BR', :user_id => user.id
      end

      it 'returns http success' do
        response.should be_success
      end

      it 'assigns channel' do
        assigns[:channel] = Channel.new
      end

      it { should render_template(:new) }
    end # context 'when logged'

    context 'when not logged' do
      before do
        get :new, :locale => 'pt-BR', :user_id => user.id
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:valid_params) do
      {
        :locale => 'pt-BR', :user_id => user.id,
        :channel => { :name => 'The Simpsons FC' }
      }
    end

    context 'when logged' do
      before do
        controller.stub(:current_user => user)
      end

      context 'with valid params' do
        before do
          post :create, valid_params
        end

        it { should redirect_to(user_channel_path(user, Channel.last)) }

        it { should set_the_flash.to('Seu canal está pronto para transmitir!') }

        it { response.should be_redirect }

        it 'associates channel with its owner' do
          user.channels.length.should_not == 0
        end
      end # context 'with valid params'

      context 'with invalid params' do
        let(:invalid_params) do
          {
            :locale => 'pt-BR', :user_id => user.id,
            :channel => { :name => '' }
          }
        end

        before do
          post :create, invalid_params
        end

        it { should set_the_flash.to('Ops! Não foi possível criar o canal.').now }

        it { response.should be_success }

        it { should render_template(:new) }
      end # context 'with invalid params'
    end # context 'when logged'

    context 'when not logged' do
      before do
        post :create, valid_params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end # describe 'POST create'

  describe 'GET edit' do
    let(:channel) { FactoryGirl.create(:channel) }
    let(:params) do
      { :locale => 'pt-BR', :user_id => channel.owner.id, :id => channel.id }
    end

    context 'when logged as channels owner' do
      before do
        controller.stub(:current_user => channel.owner)
        get :edit, params
      end

      it { response.should be_success }

      it { should render_template(:edit) }

      it 'assigns channel' do
        assigns[:channel] = channel
      end
    end # context 'when logged as channels owner'

    context 'when logged as user other than channels owner' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        controller.stub(:current_user => user)
        get :edit, params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when logged as user other than channels owner'

    context 'when not logged' do
      before do
        get :edit, params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end

  describe 'POST update' do
    let(:channel) { FactoryGirl.create(:channel) }
    let(:common_params) do
      { :locale => 'pt-BR',:user_id => channel.owner.id, :id => channel.id }
    end

    context 'when logged as channels owner' do
      before do
        controller.stub(:current_user => channel.owner)
      end

      context 'with valid params' do
        let(:valid_params) do
          { :channel => { :name => 'Some new name' } }.merge(common_params)
        end

        before do
          post :update, valid_params
        end

        it { should set_the_flash[:notice].to('Os dados do canal foram atualizados.') }

        it 'returns http success' do
          response.should be_redirect
        end

        it { should redirect_to(user_channel_path(channel.owner, channel)) }

        it 'updates_channel' do
          c = Channel.find(channel.id) # Carrega o canal atualizado
          valid_params[:channel].each do |attr_name, attr_value|
            c.send(attr_name).should == attr_value
          end
        end
      end # context 'with valid params'

      context 'with invalid params' do
        let(:invalid_params) do
          { :channel => { :name => '' } }.merge(common_params)
        end

        before do
          post :update, invalid_params
        end

        it { response.should be_success }

        it 'sets tha flash error message' do
          should set_the_flash[:error].to('Ops! Não foi possível atualizar o canal.').now
        end
      end # context 'with invalid params'
    end # context 'when logged as channels owner'

    context 'when logged as user other than channels owner' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        controller.stub(:current_user => user)
        post :update, common_params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when logged as user other than channels owner'

    context 'when not logged' do
      before do
        post :update, common_params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end # describe 'POST update'

  describe 'DELETE destroy' do
    let(:channel) { FactoryGirl.create(:channel) }
    let(:params) do
      { :user_id => channel.owner.id, :id => channel.id, :locale => 'pt-BR' }
    end

    context 'when logged as channels owner' do
      before do
        controller.stub(:current_user => channel.owner)
        post :destroy, params
      end

      it 'destroys the channel' do
        expect {
          Channel.find(channel.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it { should set_the_flash[:notice].to('O canal foi removido.') }

      it { response.should be_redirect }

      it { should redirect_to(root_path) }
    end # context 'when logged as channels owner'

    context 'when logged as user other than channels owner' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        controller.stub(:current_user => user)
        post :destroy, params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when logged as user other than channels owner'

    context 'when not logged' do
      before do
        post :destroy, params
      end

      it { response.should redirect_to(root_path) }

      it { should set_the_flash[:alert] }
    end # context 'when not logged'
  end # describe 'DELETE destroy'
end
