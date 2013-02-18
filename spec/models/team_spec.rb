require 'spec_helper'

describe Team do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sport_type) }
  it { should have_many(:players) }
  it { should have_many(:moves) }
end
