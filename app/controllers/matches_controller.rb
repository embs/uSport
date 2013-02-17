class MatchesController < ApplicationController

  def show
    @match = Match.find(params[:id])
    @user = User.find(params[:user_id])
  end

end
