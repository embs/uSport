require 'spec_helper'

describe HelpController do

  describe 'GET index' do
    before do
      get :index
    end

    it { response.should be_success }

    it { should render_template(:index) }
  end

  describe 'GET topic' do
    before do
      get :topic, topic: 'sign_up'
    end

    it { response.should be_success }

    it { should render_template(:sign_up) }
  end
end
