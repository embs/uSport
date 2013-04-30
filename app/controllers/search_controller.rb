# encoding: utf-8
class SearchController < ApplicationController
  skip_authorization_check

  def index
    @users = User.search_by_attrs(params[:q])
    @teams = Team.search_by_attrs(params[:q])
    @players = Player.search_by_attrs(params[:q])
    @matches = Match.includes(:channel, :teams).search_by_attrs(params[:q])
    flash[:notice] = "#{@users.length} usuário(s), #{@teams.length} time(s), " + \
      "#{@players.length} jogador(es) e #{@matches.length} partidas encontrada(s)"
  end
end
