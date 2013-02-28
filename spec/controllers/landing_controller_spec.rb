require 'spec_helper'

describe LandingController do

  describe 'GET index' do
    before do
      5.times do
        FactoryGirl.create(:channel)
      end
      get :index
    end

    it 'assigns channels' do
      assigns[:channels].should == Channel.all
    end

    it { response.should be_success }

    it { should render_template(:index) }

  end

end