# encoding: utf-8
require 'spec_helper'

describe ChannelsController do

  describe 'GET index' do
    before do
      get :index, :locale => 'pt-BR'
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns channels' do
      assigns[:channels] = Channel.all
    end
  end

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
  end

  describe 'GET new' do
    before do
      get :new, :locale => 'pt-BR', :user_id => 1
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns channel' do
      assigns[:channel] = Channel.new
    end
  end

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      controller.stub(:current_user => user)
    end

    context 'with valid params' do
      let(:valid_params) do
        {
          :locale => 'pt-BR', :user_id => user.id,
          :channel => { :name => 'The Simpsons FC' }
        }
      end

      before do
        post :create, valid_params
      end

      it { should redirect_to(user_channel_path(user, Channel.last)) }

      it { should set_the_flash.to('Seu canal está pronto para transmitir!') }

      it 'returns http success' do
        response.should be_redirect
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

      it 'returns http success' do
        response.should be_success
      end

      it { should render_template(:new) }
    end # context 'with invalid params'
  end # describe 'POST create'

  describe 'GET edit' do
    let(:channel) { FactoryGirl.create(:channel) }

    before do
      get :edit, :locale => 'pt-BR', :user_id => channel.owner.id,
        :id => channel.id
    end

    it 'returns http success' do
      response.should be_success
    end

    it { should render_template(:edit) }

    it 'assigns channel' do
      assigns[:channel] = channel
    end
  end

  describe 'POST update' do
    let(:channel) { FactoryGirl.create(:channel) }
    let(:common_params) do
      { :locale => 'pt-BR',:user_id => channel.owner.id, :id => channel.id }
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

      it 'returns http success' do
        response.should be_success
      end

      it { should set_the_flash[:error].
        to('Ops! Não foi possível atualizar o canal.').now }
    end # context 'with invalid params'
  end # describe 'POST update'

  describe 'DELETE destroy' do
    let(:channel) { FactoryGirl.create(:channel) }

    before do
      post :destroy, :user_id => channel.owner.id, :id => channel.id,
        :locale => 'pt-BR'
    end

    it 'destroys the channel' do
      expect {
        Channel.find(channel.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it { should set_the_flash[:notice].to('O canal foi removido.') }

    it 'returns http success' do
      response.should be_redirect
    end

    it { should redirect_to(root_path) }
  end
end
