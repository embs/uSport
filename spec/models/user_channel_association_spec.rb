require 'spec_helper'

describe UserChannelAssociation do
   it { should validate_presence_of(:user) }
   it { should validate_presence_of(:channel) }
end
