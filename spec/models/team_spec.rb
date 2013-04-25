require 'spec_helper'

describe Team do
  # Atributos
  it { should respond_to :name }
  it { should respond_to :abbreviation }
  it { should respond_to :players }
  it { should respond_to :sport_type }
  it { should respond_to :avatar }

  # Associações
  it { should have_many(:players) }
  it { should have_many(:moves) }
  it { should have_and_belong_to_many :matches }
  it { should have_attached_file(:avatar) }
  it { should have_many(:user_team_associations) }
  it { should have_many(:users).through(:user_team_associations) }

  # Validações
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sport_type) }
  it { should validate_presence_of(:abbreviation) }
  it { should ensure_length_of(:abbreviation).is_at_most(3) }

  describe '#find_player_by_text_input' do
    # let(:team) { FactoryGirl.create :team }

    context 'with valid input' do
      context 'when player does exist' do
        before do
          @player = FactoryGirl.create(:player, first_name: 'Zagalo', number: 80,
            team: subject)
        end

        it 'retrieves player' do
          subject.find_player_by_text_input("#80 Zagalo").should == @player
        end

        context 'and has a compounded first name' do
          before do
            @player.update_attribute(:first_name, 'Jeferson Zagalo')
          end

          it 'retrieves players' do
            subject.find_player_by_text_input("#80 Jeferson Zagalo").should == @player
          end
        end
      end

      context 'when player does not exist' do
        it 'returns nil' do
          subject.find_player_by_text_input("#80 Zagalo").should be_nil
        end
      end # context 'when player does not exist'
    end # context 'with valid input'

    context 'with invalid input' do
      it 'raises error' do
        expect {
          Player.find_by_text_input("Seedorf")
        }.to raise_error
      end
    end # context 'with invalid input'
  end # describe '#find_player_by_text_input'
end
