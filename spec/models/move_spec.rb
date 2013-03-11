require 'spec_helper'

describe Move do
  # Associações
  it { should belong_to :match }
  it { should belong_to :player }
  it { should belong_to :team }
  it { should have_many :comments }

  # Validações
  it { should validate_presence_of :match }
  it { should validate_presence_of :kind }
  it { should validate_presence_of :player }
end
