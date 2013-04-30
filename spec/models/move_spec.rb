require 'spec_helper'

describe Move do
  # Associações
  it { should belong_to :match }
  it { should belong_to :player }
  it { should belong_to :team }
  it { should have_many :comments }

  # Validações
  it { should validate_presence_of :match }
  it { should validate_presence_of :kind }
  # Devido a tipos especiais de Move
  it { should_not validate_presence_of :player }
  it { should_not validate_presence_of :team }

  describe '::points_for' do
    it 'returns 6 for touchdown-run' do
      Move.points_for('touchdown-run').should == 6
    end

    it 'returns 6 for touchdown-pass' do
      Move.points_for('touchdown-pass').should == 6
    end

    it 'returns 6 for touchdown-return' do
      Move.points_for('touchdown-return').should == 6
    end

    it 'returns 3 for fieldgoal' do
      Move.points_for('fieldgoal').should == 3
    end

    it 'returns 1 for extrapoint' do
      Move.points_for('extrapoint').should == 1
    end
  end
end
