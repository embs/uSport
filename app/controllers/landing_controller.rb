# encoding: utf-8
class LandingController < ApplicationController
 skip_authorization_check

  def index
  	@active_page = "Home"
    authorize! :show, Channel
    @channels = Channel.includes(:owner, matches: [:teams]).all
    @matches_per_day = Match.includes(:channel, :teams).group_by(&:day)
    @matches = Match.includes(:channel, :teams).order('viewers_count DESC').all
    if params[:sport]
      flash.now[:notice] = 'Em breve você poderá filtrar canais e eventos de acordo
        com os esportes disponíveis. Aguarde!'
    end
  end

end
