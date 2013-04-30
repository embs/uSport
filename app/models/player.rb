class Player < ActiveRecord::Base
  include PgSearch

  attr_accessible :first_name, :last_name, :position, :number, :team_id, :team
  validates_presence_of :first_name
  validates_numericality_of :number, greater_than_or_equal_to: 1,  allow_nil: true, less_than_or_equal_to: 100
  belongs_to :team
  has_many :moves

  # Busca
  pg_search_scope :search_by_attrs,
    against: [:first_name, :last_name, :position, :number],
    using: { tsearch: { prefix: true } }

  # Retorna um jogador baseado no input de texto do typeahead
  # Player.find_by_text_input('#80 Zagalo')
  # => <#Player first_name: Zagalo>
  def self.find_by_text_input(input)
    splitted = input.split
    splitted.shift()
    splitted = splitted.join(" ")

    # Levanta exceção se não houver no mínimo duas strings (#n nome)
    raise 'Invalid input text for player identification' if splitted.length < 2

    Player.find_by_first_name(splitted)
  end

  def display_name
    "#{self.first_name} #{self.try(:last_name)}"
  end
end
