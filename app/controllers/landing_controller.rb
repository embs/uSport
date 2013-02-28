# encoding: utf-8

class LandingController < ApplicationController

  def index
    authorize! :show, Channel
    @channels = Channel.all
  end

end