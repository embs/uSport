require 'spec_helper'

describe Channel do
  # Setters & Getters
  it { should respond_to :name }
  it { should respond_to :description }

  # Associações
  it { should have_many(:matches) }
  it { should belong_to(:owner) }
  it { should have_attached_file(:avatar) }
  it { should have_many(:users).through(:user_channel_associations) }
  it { should have_many(:favorited_users).through(:user_favorite_channels) }

  # Validação
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(5).is_at_most(50) }

  describe '.is_favorite_of?' do
    let(:nice_user) { FactoryGirl.create :user }
    let(:nasty_user) { FactoryGirl.create :user }
    let(:channel) { FactoryGirl.create :channel }

    before do
      UserFavoriteChannel.create(user: nice_user, channel: channel)
    end

    it 'returns true when user has favorited channel' do
      channel.is_favorite_of?(nice_user).should be_true
    end

    it 'returns false when user hasnt favorited channel' do
      channel.is_favorite_of?(nasty_user).should be_false
    end

    it 'returns false when nil user is passed' do
      channel.is_favorite_of?(nil).should be_false
    end
  end
end
