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

  # Validações
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }

  describe '#create_with_omniauth' do
    before do
      set_omniauth
      @omniauth_auth = OmniAuth.config.mock_auth[:facebook]
    end

    it 'creates a valid user' do
      User.create_with_omniauth(@omniauth_auth).should be_valid
    end
  end
end
