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

  def message
    case self.kind
    when "punt"
      "Punt! Retorno de #{self.yards} jardas por #{self.player.first_name} (##{self.player.number})."
    when "touchdown"
      "Touchdown de ##{self.player.number}! #{self.player.first_name}! 6 pontos para o(s) #{self.team.name}!"
    when "kickoff"
      "Kickoff! #{self.player.first_name} (##{self.player.number}) do(s) #{self.team.name} inicia a jogada!"
    when "field-goal-is-good"
      "Field goal para o(s) #{self.team.name}! 3 pontos feitos por #{self.player.first_name} (##{self.player.number})!"
    when "fumble"
      "Fumble! #{self.player.first_name} (##{self.player.number}) deixou a bola cair."
    when "interceptation"
      "#{self.player.first_name} (##{self.player.number}) do(s) #{self.team.name} interceptou o time adversário!"
    else
      "#{self.kind.capitalize} por #{self.player.first_name} (##{self.player.number})!"
    end
  end
end
