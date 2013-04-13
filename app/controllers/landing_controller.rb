# encoding: utf-8
class LandingController < ApplicationController

  def index
  	@active_page = "Home"
    authorize! :show, Channel
    @channels = Channel.all
    @matches = Match.all
    if params[:sport]
      flash.now[:notice] = 'Em breve você poderá filtrar canais e eventos de acordo
        com os esportes disponíveis. Aguarde!'
    end
  end

end
