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
    @move = Move.find(params[:move_id])
    @comment = Comment.new(params[:comment]) do |c|
      c.author = current_user
      c.move = @move
    end
    authorize! :create, @comment
    @comment.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.includes(:move).find(params[:id])
    @move = @comment.move
    authorize! :manage, @comment
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end
end
