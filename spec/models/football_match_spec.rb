require 'spec_helper'

describe FootballMatch do
  let(:match) { FactoryGirl.build(:football_match) }

  it 'has two teams' do
    match.should have_at_least(1).error_on(:teams)
  end
end
