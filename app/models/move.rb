class Move < ActiveRecord::Base
  attr_accessible :description, :kind, :minute, :player, :points, :quarter, :yards,
    :team

  belongs_to :match
  belongs_to :player
  belongs_to :team #TODO Restrição: deve ser o mesmo time do jogador

  validates_presence_of :kind, :match

  def to_string
  	if ["Kickoff", "Punt"].include? self.kind.capitalize
  		"#{self.kind.capitalize}! Retorno de #{self.yards} jardas por ##{self.player.number} #{self.player.first_name}"
  	elsif self.kind == "Fumble"
  		"Fumble! #{self.player.first_name} deixou a bola cair"
    else
  	  "#{self.kind.capitalize}! ##{self.player.number} #{self.player.first_name}"
    end
  end
end
