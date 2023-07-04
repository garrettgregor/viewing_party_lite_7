# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:viewing_parties).through(:user_parties) }
  end
end
