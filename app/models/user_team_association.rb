class UserTeamAssociation < ActiveRecord::Base
  extend Enumerize

  attr_accessible :user, :team, :role

  # Atributos
  enumerize :role, in: [:owner, :manager], default: :manager

  # Associações
  belongs_to :user
  belongs_to :team

  # Validações
  validates_presence_of :user, :team, :role
end
