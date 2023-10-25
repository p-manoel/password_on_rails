# frozen_string_literal: true

module UserPassword
  class Record < ApplicationRecord
    self.table_name = 'user_passwords'

    belongs_to :user, class_name: '::User::Record'
    belongs_to :password, class_name: '::Password::Record'

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
end
