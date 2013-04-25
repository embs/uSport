require 'spec_helper'

describe UserTeamAssociation do
  # Atributos
  it { should respond_to(:role) }

  # Associações
  it { should belong_to(:user) }
  it { should belong_to(:team) }
end
