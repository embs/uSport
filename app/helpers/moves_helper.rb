module MovesHelper
  # Recebe um move e retorna o outro time da partida (que não é o do move)
  def the_other_team_from(move)
    move.team == move.match.teams[0] ? move.match.teams[1] : move.match.teams[0]
  end
end
