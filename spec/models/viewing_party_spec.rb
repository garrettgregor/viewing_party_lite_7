# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:users).through(:user_parties) }
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
      expect(viewing_party_1.host_name).to eq('Michael')
      expect(viewing_party_2.host_name).to eq('Michael')
      expect(viewing_party_3.host_name).to eq('Garrett')
    end
  end
end
