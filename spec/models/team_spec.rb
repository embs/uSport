require 'spec_helper'

describe Team do
  # Atributos
  it { should respond_to :name }
  it { should respond_to :abbreviation }
  it { should respond_to :players }
  it { should respond_to :sport_type }
  it { should respond_to :avatar }

  # Associações
  it { should have_many(:players) }
  it { should have_many(:moves) }
  it { should have_and_belong_to_many :matches }
  it { should have_attached_file(:avatar) }

  # Validações
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sport_type) }
  it { should validate_presence_of(:abbreviation) }
  it { should ensure_length_of(:abbreviation).is_at_most(3) }
end
