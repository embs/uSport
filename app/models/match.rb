class Match < ActiveRecord::Base
  include PgSearch

  # Atributos acessíveis
  attr_accessible :date, :name, :type, :value1, :value2, :channel, :channel_id,
    :place

  # Associações
  has_many :moves
  has_and_belongs_to_many :teams
  belongs_to :channel

  # Validações
  validates_presence_of :date, :name, :channel
  validates_length_of :name, in: 5..80

  # Busca
  pg_search_scope :search_by_attrs,
    against: [:name], associated_against: { teams: :name },
    using: { tsearch: { prefix: true } }
end
