# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:viewing_parties).through(:user_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'instance methods' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }
    let!(:user3) { User.create!(name: 'Shannon', email: 'shannon123@gmail.com') }

    let!(:viewing_party_1) do
      ViewingParty.create!(
        duration: 175,
        start_date: 'Wed, 07 Aug 2024',
        start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
        movie_id: 238,
        host_id: user1.id
      )
    end

    let!(:viewing_party_2) do
      ViewingParty.create!(
        duration: 122,
        start_date: 'Wed, 08 Aug 2024',
        start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
        movie_id: 239,
        host_id: user1.id
      )
    end

    let!(:viewing_party_3) do
      ViewingParty.create!(
        duration: 202,
        start_date: 'Wed, 09 Aug 2024',
        start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
        movie_id: 240,
        host_id: user2.id
      )
    end

    it 'returns a list of the viewing parties a user is hosting', :vcr do
      expect(user1.hosted_parties).to eq([viewing_party_1, viewing_party_2])
      expect(user2.hosted_parties).to eq([viewing_party_3])
      expect(user3.hosted_parties).to eq([])
    end
  end
end
