# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Password::Record, type: :model do
  describe 'associations' do
    it { should have_many(:user_passwords).dependent(:destroy) }
    it { should have_many(:users).through(:user_passwords) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
  end
end
