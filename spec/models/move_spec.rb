require 'spec_helper'

describe Move do
  it { should validate_presence_of :match }
  it { should validate_presence_of :kind }
  it { should belong_to :match }
  it { should belong_to :player }
end
