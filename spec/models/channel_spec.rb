require 'spec_helper'

describe Channel do
  it { should validate_presence_of(:name) }
  it { should have_many(:matches)}
  it { should belong_to(:owner) }
end
