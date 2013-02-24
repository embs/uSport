class UsersController < ApplicationController

  def index
    users = User.all
    selected = users.select { |u| u.first_name.downcase.include?(params[:q].downcase) }

    respond_to do |format|
      format.json { render :json => selected.collect(&:first_name) }
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Sua conta foi atualizada!"
      redirect_to edit_user_path(@user)
    else
      flash.now[:error] = "Ops! Verifique os campos e tente novamente."
      render 'edit'
    end
  end
end
