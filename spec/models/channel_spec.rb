require 'spec_helper'

describe Channel do
  # Associações
  it { should have_many(:matches) }
  it { should belong_to(:owner) }
  it { should have_attached_file(:avatar) }

  # Validação
  it { should validate_presence_of(:name) }
end
