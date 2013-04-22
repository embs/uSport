class Team < ActiveRecord::Base
  # Getters & Setters
  attr_accessible :name, :abbreviation, :players, :sport_type, :avatar, :is_official

  # Associações
  has_many :players
  has_many :moves
  has_and_belongs_to_many :matches
  has_attached_file :avatar, :styles => { thumb: ["128x128#", :png] },
    default_url: "avatars/team/missing.gif"

  # Validações
  validates_presence_of :name, :abbreviation, :sport_type
  validates_inclusion_of :is_official, in: [true, false]
  validates_length_of :abbreviation, maximum: 3

  def find_player_by_text_input(input)
    splitted = input.split
    number = splitted.shift.parameterize

    self.players.where(number: number.to_i).first
  end
end
