require 'spec_helper'

describe Match do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:name) }
end
