require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel, :owner => user) }
  let(:match) { FactoryGirl.create(:match, :channel => channel) }
  let(:move) { FactoryGirl.create(:move_with_comment, :match => match) }

  before do
    @params = {
      :user_id => user.id, :channel_id => channel.id, :match_id => match.id,
      :move_id => move.id, :locale => 'pt-BR'
    }
  end

  describe 'GET index' do
    before do
      get :index, @params
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns comments' do
      assigns[:comments].should == move.comments
    end
  end

  describe 'GET new' do
    before do
      get :new, @params
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns comment' do
      assigns[:comment] = Comment.new
    end
  end

  describe 'POST create' do
    let(:comment_author) { FactoryGirl.create(:user) }
    let(:comment) { { :body => "I'll make an offer he can't refuse." } }

    before do
      controller.stub(:current_user => comment_author)
    end

    it 'creates a new comment' do
      expect {
        post :create, @params.merge(:comment => comment)
      }.to change(Comment, :count).by(1)
    end

    it 'associates new comment to current user' do
      expect {
        post :create, @params.merge(:comment => comment)
      }.to change(comment_author.comments, :count).by(1)
    end

    it 'associates new comment to the proper move' do
      expect {
        post :create, @params.merge(:comment => comment)
      }.to change(move.comments, :count).by(1)
    end
  end

end
