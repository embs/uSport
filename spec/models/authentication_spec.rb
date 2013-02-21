require 'spec_helper'

describe Authentication do
  # Métodos
  it { should respond_to :provider }
  it { should respond_to :user }
  it { should respond_to :uid }
  it { should respond_to :token }

  # Associação
  it { should belong_to :user }

  # Validações
  it { should validate_presence_of :user }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :uid }
end
