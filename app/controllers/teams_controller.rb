# encoding: utf-8
class TeamsController < ApplicationController

  def index
    authorize! :show, Team
    @teams = Team.all
    @active_page = "AllTeams"
    if params[:user_id]
      flash.now[:notice] = "Em breve você poderá navegar entre times filtrando
        apenas aqueles que você pode moderar. Aguarde!"
    end
  end

  def show
    authorize! :show, Team
    @team = Team.find(params[:id])
  end

  def new
    authorize! :create, Team
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    authorize! :create, @team
    if @team.save
      UserTeamAssociation.create(user: current_user, team: @team, role: :owner)
      flash[:notice] = 'Time criado!'
      redirect_to teams_path
    else
      flash.now[:error] = 'Ops! Não foi possível criar o time.'
      render 'edit'
    end
  end

  def edit
    @team = Team.find(params[:id])
    authorize! :edit, @team
  end

  def update
    @team = Team.find(params[:id])
    authorize! :edit, @team
    if @team.update_attributes(params[:team])
      flash[:notice] = 'Time atualizado!'
      redirect_to root_path
    else
      flash.now[:error] = 'Ops! Não foi possível atualizar o time.'
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    authorize! :manage, @team
    @team.destroy
    flash[:notice] = 'Time removido!'
    redirect_to :back
  end
end
