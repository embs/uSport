require 'spec_helper'

describe Match do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:name) }
  it { should have_many(:moves)}
  it { should belong_to(:channel) }
end
