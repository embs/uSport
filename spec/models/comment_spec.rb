require 'spec_helper'

describe Comment do
  it { should validate_presence_of :author }
  it { should validate_presence_of :body }
  it { should validate_presence_of :move }
  it { should belong_to :author }
  it { should belong_to :move }
end
