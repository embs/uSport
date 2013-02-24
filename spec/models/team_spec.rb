require 'spec_helper'

describe Team do
  # Associações
  it { should have_many(:players) }
  it { should have_many(:moves) }
  it { should have_and_belong_to_many :matches }
  it { should have_attached_file(:avatar) }

  # Validações
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sport_type) }
end
