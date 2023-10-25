# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::UserPassword::Record, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:password) }
  end
end
