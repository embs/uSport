class CommentsController < ApplicationController
  def index
    authorize! :read, Comment
    @comments = Move.find(params[:move_id]).comments
  end

  def new
    authorize! :create, Comment
    @comment = Comment.new
  end

  def create
    move = Move.find(params[:move_id])
    comment = Comment.new(params[:comment]) do |c|
      c.author = current_user
      c.move = move
    end
    authorize! :create, comment
    comment.save

    redirect_to user_channel_match_path(current_user, move.match.channel, move.match)
  end
end
