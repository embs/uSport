require 'spec_helper'

describe Player do
  # Associações
  it { should belong_to (:team) }
  it { should have_many(:moves) }

  # Validações
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_numericality_of(:number) }
end
