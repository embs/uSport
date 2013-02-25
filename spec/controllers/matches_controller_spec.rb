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
end
