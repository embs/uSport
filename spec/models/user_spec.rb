require 'spec_helper'

describe User do
  # Métodos
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :email }
  it { should respond_to :username }
  it { should respond_to :channels }
  it { should respond_to :comments }

  # Associações
  it { should have_many(:channels).through(:user_channel_associations) }
  it { should have_many :comments }
  it { should have_many :authentications }
  it { should have_attached_file(:avatar) }
  it { should have_many(:favorite_channels).through(:user_favorite_channels) }

  # Validações
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { User.observers.disable(:all) { should validate_uniqueness_of(:email) } }

  describe '#create_with_omniauth' do
    before do
      set_omniauth
      @omniauth_auth = OmniAuth.config.mock_auth[:facebook]
    end

    it 'creates a valid user' do
      User.create_with_omniauth(@omniauth_auth).should be_valid
    end

    context 'when username already exists' do
      before do
        FactoryGirl.create(:user, username: 'mikemyers')
      end

      it 'creates a valid user' do
        User.create_with_omniauth(@omniauth_auth).should be_valid
      end
    end
  end

  describe '.display_name' do
    let(:user) { FactoryGirl.create :user }

    it 'returns user first name + last name' do
      user.display_name.should == "#{user.first_name} #{user.last_name}"
    end
  end
end
