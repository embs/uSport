# encoding: utf-8
class MatchesController < ApplicationController
  protect_from_forgery :except => [:auth, :viewers] # stop rails CSRF protection for this action
  skip_authorization_check only: [:auth, :viewers]
  layout :choose_layout

  def show
    @match = Match.find(params[:id])
    authorize! :show, @match
    # @user = User.find(params[:user_id])
    @moves = @match.moves.order('created_at DESC').page(params[:page])
    # Daqui para baixo são setadas as variáveis utilizadas para criação de move
    @move = Move.new(:match => @match)
    if can?(:create, @move)
      @kinds = [["Punt", "punt"], ["Extrapoint", "extrapoint"], ["Touchdown (Corrida)", "touchdown-run"],
        ["Touchdown (Retorno)", "touchdown"],
        ["Touchdown (Passe)", "touchdown-pass"],
        ["Kickoff", "kickoff"], ["Field Goal", "fieldgoal"],
        ["Fumble", "fumble"], ["Interceptação", "interceptation"], ["Falta", "penalty"],
        ["Sack", "sack"], ["Fim de jogo", "end"],
        ["Tempo", "time"], ["Turnover", "turnover"], ["Comentário", "comment"],
        ["Passe", "pass"], ["Corrida", "run"]]
      @minutes = [["--", 0]]
      15.times do |n|
        @minutes << [(n+1).to_s, (n+1)]
      end
      @yards = []
      151.times do |n|
        @yards << [n.to_s, n]
      end
    end
    session[:return_to] = request.fullpath if !current_user
  end

  def new
    authorize! :manage, Channel.find_by_id(params[:channel_id]) || current_user.try(:channels).try(:first)
    @match = FootballMatch.new #FIXME Por enquanto, apenas partidas desse tipo
    authorize! :create, Match
    @teams = Team.all # necessário para formulário de criação
  end

  def create
    channel = Channel.find(params[:channel_id])
    authorize! :manage, channel
    teams = params[:football_match].delete(:teams_ids) if params[:football_match][:teams_ids]
    @teams = Team.all
    @match = FootballMatch.new(params[:football_match]) do |m|
      m.teams << Team.find(teams) if teams
      m.channel = channel
    end
    if params[:date] # atualiza a hora da partida sem modificar a data
      @match.date = @match.date.change(:hour => params[:date][:'time(4i)'].to_i ,
        :min => params[:date][:'time(5i)'].to_i)
    end
    if @match.save
      flash[:notice] = 'Partida criada!'
      redirect_to match_path(@match)
    else
      flash.now[:alert] = 'Ops! Não foi possível criar a partida.'
      render 'new'
    end
  end

  def edit
    @match = Match.find(params[:id])
    @teams = Team.all # necessário para formulário de edição
    authorize! :manage, @match
  end

  def update
    match = Match.find(params[:id])
    authorize! :manage, match
    teams = params[:football_match].delete(:teams_ids) if params[:football_match][:teams_ids]
    match.update_attributes(params[:football_match])
    match.teams = Team.find(teams) if teams
    if match.save
      flash[:notice] = 'Partida atualizada!'
    else
      flash[:error] = 'Ops! Não foi possível atualizar a partida.'
    end

    redirect_to match_path(match)
  end

  def score
    @match = Match.find(params[:id])
  end

  def auth
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        user_id: SecureRandom.hex(4) #DISCUSS Solução para usuários não logados
      })
    render json: response.stringify_keys!
  end

  def viewers
    webhook = Pusher.webhook(request)
    if webhook.valid?
      webhook.events.each do |event|
        match = Match.find(event["channel"].rpartition('-').last)
        count = parse_count_from_json(Pusher.get("/channels/#{event['channel']}",
          info: 'user_count'))
        match.update_attribute(:viewers_count, count)
      end
    end
    render nothing: true
  end

  private

  def choose_layout
    if action_name == "score"
      "clean"
    else
      "application"
    end
  end

  def parse_count_from_json(response)
    if response[:occupied]
      response[:user_count]
    else
      0
    end
  end

end
