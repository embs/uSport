class Match < ActiveRecord::Base
  # Atributos acessíveis
  attr_accessible :date, :name, :type, :value1, :value2

  # Associações
  has_many :moves
  has_and_belongs_to_many :teams
  belongs_to :channel

  # Validações
  validates_presence_of :date, :name, :channel
end
