# frozen_string_literal: true

class UserPassword < ApplicationRecord
  belongs_to :user
  belongs_to :password

  ROLES = %w[viewer editor owner].freeze

  validates :role, presence: true, inclusion: { in: ROLES }

  attribute :role, default: :viewer

  def owner?
    role == 'owner'
  end

  def viewer?
    role == 'viewer'
  end

  def editor?
    role == 'editor'
  end

  def editable?
    owner? || editor?
  end

  def shareable?
    owner?
  end

  def deletable?
    owner?
  end
end
