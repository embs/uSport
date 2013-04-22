require 'spec_helper'

describe UserFavoriteChannel do
  # Atributos e Métodos
  it { should respond_to :user }
  it { should respond_to :channel }

  # Associações
  it { should belong_to :user }
  it { should belong_to :channel }
end
