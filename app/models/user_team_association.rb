class UserTeamAssociation < ActiveRecord::Base
  extend Enumerize

  attr_accessible :user, :team, :role

  # Atributos
  enumerize :role, in: [:owner, :manager], default: :manager

  # Associações
  belongs_to :user
  belongs_to :team
end
