require 'spec_helper'

describe Player do
  # Atributos
  it { should respond_to(:position) }

  # Associações
  it { should belong_to(:team) }
  it { should have_many(:moves) }

  # Validações
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_numericality_of(:number) }

  describe '#find_by_text_input' do

    context 'wich is valid' do
      context 'when player does exist' do
        before do
          @player = FactoryGirl.create(:player, first_name: 'Zagalo', number: 80)
        end

        it 'retrieves players' do
          Player.find_by_text_input("#80 Zagalo").should == @player
        end

        context 'and has a compounded first name' do
          before do
            @player.update_attribute(:first_name, 'Jeferson Zagalo')
          end

          it 'name should be compounded' do
            @player.first_name.should == 'Jeferson Zagalo'
          end

          it 'retrieves players' do
            Player.find_by_text_input("#80 Jeferson Zagalo").should == @player
          end
        end
      end

      context 'when player does not exist' do
        it 'returns nil' do
          Player.find_by_text_input("#80 Zagalo").should be_nil
        end
      end
    end # context 'wich is valid'

    context 'which is invalid' do
      it 'raises error' do
        expect {
          Player.find_by_text_input("Seedorf")
        }.to raise_error
      end
    end
  end # describe '#find_by_text_input'
end
