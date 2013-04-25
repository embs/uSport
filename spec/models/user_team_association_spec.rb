require 'spec_helper'

describe UserTeamAssociation do
  # Atributos
  it { should respond_to(:role) }

  # Associações
  it { should belong_to(:user) }
  it { should belong_to(:team) }

  # Validações
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:team) }
  it { should validate_presence_of(:role) }
end
