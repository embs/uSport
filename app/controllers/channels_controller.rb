class ChannelsController < ApplicationController

  def index
    @channels = Channel.all
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def new
    @channel = Channel.new
  end

  def create
    channel = Channel.new(params[:channel])
    channel.owner = current_user
    channel.save
    redirect_to root_path
  end

end
