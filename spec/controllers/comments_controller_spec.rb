require 'spec_helper'
require 'cancan/exceptions'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:channel) { FactoryGirl.create(:channel, owner: user) }
  let(:match) { FactoryGirl.create(:match, channel: channel) }
  let(:move) { FactoryGirl.create(:move_with_comment, match: match) }
  let(:params) { { match_id: match.id, move_id: move.id } }

  describe 'GET index' do
    before do
      get :index, params
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'assigns comments' do
      assigns[:comments].should == move.comments
    end
  end

  describe 'GET new' do
    context 'when logged' do
      before do
        controller.stub(current_user: user)
        get :new, params
      end

      it 'returns http success' do
        response.should be_success
      end

      it 'assigns comment' do
        assigns[:comment] = Comment.new
      end
    end

    context 'when not logged' do
      before do
        get :new, params
      end

      it { response.should redirect_to(new_user_session_path) }

      it { should set_the_flash[:alert] }
    end
  end

  describe 'POST create' do
    let(:comment_author) { FactoryGirl.create(:user) }
    let(:comment) { { body: "I'll make an offer he can't refuse." } }

    before do
      params.merge!(comment: comment, format: :js)
      controller.stub(current_user: comment_author)
    end

    it 'creates a new comment' do
      expect {
        post :create, params
      }.to change(Comment, :count).by(1)
    end

    it 'associates new comment to current user' do
      expect {
        post :create, params
      }.to change(comment_author.comments, :count).by(1)
    end

    it 'associates new comment to the proper move' do
      expect {
        post :create, params
      }.to change(move.comments, :count).by(1)
    end
  end

  describe 'DELETE destroy' do
    let(:comment) { FactoryGirl.create(:comment, move: move) }

    before do
      controller.stub(current_user: comment.author)
      delete :destroy, params.merge(id: comment, format: :js)
    end

    it 'destroys comment' do
      expect {
        Comment.find(comment.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it { response.should be_success }

    it { assigns[:comment].should == comment }
  end
end
