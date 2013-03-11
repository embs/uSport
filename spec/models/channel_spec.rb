require 'spec_helper'

describe Channel do
  # Setters & Getters
  it { should respond_to :name }
  it { should respond_to :description }

  # Associações
  it { should have_many(:matches) }
  it { should belong_to(:owner) }
  it { should have_attached_file(:avatar) }
  it { should have_many(:users).through(:user_channel_associations) }
  it { should have_many(:favorited_users).through(:user_favorite_channels) }

  # Validação
  it { should validate_presence_of(:name) }
end
