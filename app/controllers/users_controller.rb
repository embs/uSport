class UsersController < ApplicationController

  def index
    users = User.all
    selected = users.select { |u| u.first_name.downcase.include?(params[:q].downcase) }

    respond_to do |format|
      format.json { render :json => selected.collect(&:first_name) }
    end
  end

end
