# encoding: utf-8
class Move < ActiveRecord::Base
  attr_accessible :description, :kind, :minute, :player, :points, :quarter, :yards,
    :team, :match, :player_id, :team_id

  # Associações
  belongs_to :match
  belongs_to :player
  belongs_to :team #TODO Restrição: deve ser o mesmo time do jogador
  has_many :comments

  # Validações
  validates_presence_of :kind, :match #, :player

  def self.points_for(move_kind)
    case move_kind
    when 'touchdown-run', 'touchdown-pass', 'touchdown-return'
      6
    when 'fieldgoal'
      3
    when 'extrapoint'
      1
    else
      0
    end
  end

  def main
    case self.kind
    when 'comment'
      "Comentário do transmissor"
    when 'end'
      "Fim de partida"
    when 'time'
      "Timeout!"
    else
      "#{self.kind.capitalize}, #{self.player.try(:first_name)} (##{self.player.try(:number)})!"
    end
  end

  def message
    case self.kind
    when "punt"
      "Retorno de #{self.yards} jardas."
    when "extrapoint"

    when "penalty"

    when "kickoff"
      "A partida é iniciada!"
    when "fumble"
      "O jogador deixou a bola cair."
    when "run"
      "O jogador teve um ganho de #{self.yards} jardas."
    when "turnover"

    when "time"
      "Pedido de tempo dos #{self.team.name}"
    when "touchdown-run"
      "O jogador correu #{self.yards} jardas até a endzone! 6 pontos para o(s) #{self.team.name}!"
    when "touchdown-pass"

    when "touchdown-return"

    when "fieldgoal"
      "3 pontos para o(s) #{self.team.name}!"
    when "pass"
      "Passe de QB para WR para um ganho de #{self.yards} jardas."
    when "sack"
      "O quarterback foi derrubado para uma perda de #{self.yards} jardas."
    when "interception"
      "Após passe do quarterback, a bola foi interceptada!"
    when "comment"

    when "end"

    end
  end
end
