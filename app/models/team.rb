class Team < ActiveRecord::Base
  include PgSearch

  # Getters & Setters
  attr_accessible :name, :abbreviation, :players, :sport_type, :avatar, :is_official

  # Associações
  has_many :users, through: :user_team_associations
  has_many :user_team_associations, dependent: :destroy
  has_many :players
  has_many :moves
  has_and_belongs_to_many :matches
  has_attached_file :avatar, USport::Application.config.paperclip_team

  # Validações
  validates_presence_of :name, :abbreviation, :sport_type
  validates_inclusion_of :is_official, in: [true, false]
  validates_length_of :abbreviation, maximum: 3

  # Busca
  pg_search_scope :search_by_attrs,
    against: [:name, :abbreviation, :sport_type],
    using: { tsearch: { prefix: true } }

  def find_player_by_text_input(input)
    splitted = input.split
    number = splitted.shift.parameterize

    self.players.where(number: number.to_i).first
  end
end
