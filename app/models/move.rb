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
  validates_presence_of :kind, :match, :player

  def main
    "#{self.kind.capitalize}, #{self.player.first_name} (##{self.player.number})!"
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
    when "tackle"

    when "run"
      "O jogador teve um ganho de #{self.yards} jardas."
    when "turnover"

    when "time"

    when "touchdown"
      "O jogador correu #{self.yards} jardas até a endzone! 6 pontos para o(s) #{self.team.name}!"
    when "fieldgoal"
      "3 pontos o(s) #{self.team.name}!"
    when "pass"
      "Passe de QB para WR para um ganho de #{self.yards} jardas."
    end
  end
end
