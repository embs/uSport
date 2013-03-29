class Player < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :number, :team_id, :team
  validates_presence_of :first_name, :last_name
  validates_numericality_of :number, greater_than_or_equal_to: 1
  belongs_to :team
  has_many :moves

  # Retorna um jogador baseado no input de texto do typeahead
  # Player.find_by_text_input('#80 Zagalo')
  # => <#Player first_name: Zagalo>
  def self.find_by_text_input(input)
    splitted = input.split
    splitted.shift()
    splitted = splitted.join(" ")
    
    # depois verificar se a gente vai limitar o tamanho e recolocar o raise error abaixo
    # raise Error if splitted.length != 2
    Player.find_by_first_name(splitted)
  end

  def display_name
    "#{self.first_name} #{self.last_name}"
  end
end
