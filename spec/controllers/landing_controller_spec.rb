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

    it 'assigns matches_per_day' do
      assigns[:matches_per_day].should_not be_nil
    end

    it { response.should be_success }

    it { should render_template(:index) }

  end

end