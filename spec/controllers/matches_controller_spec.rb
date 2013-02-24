require 'spec_helper'

describe MatchesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel) }

  describe 'GET new' do
    before do
      get :new, :locale => 'pt-BR', :user_id => user.id, :channel_id => channel.id
    end

    it { assigns(:match).should_not be_nil } #FIXME Verificar o problema com Match.new

    it { assigns[:teams].should == Team.all }

    it { should render_template(:new) }

    it { response.should be_success }
  end
end
