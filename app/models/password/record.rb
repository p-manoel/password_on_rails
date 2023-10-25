# frozen_string_literal: true

module Password
  class Record < ApplicationRecord
    has_many :user_passwords, dependent: :destroy
    has_many :users, through: :user_passwords

    encrypts :username, deterministic: true
    encrypts :password

    validates :url, presence: true
    validates :username, presence: true
    validates :password, presence: true

    def shareable_users
      User.excluding(users)
    end

    def can_be_edited_by?(user)
      user_passwords.find_by(user:)&.editable?
    end

    def can_be_shared_by?(user)
      user_passwords.find_by(user:)&.shareable?
    end

    def can_be_deleted_by?(user)
      user_passwords.find_by(user:)&.deletable?
    end
  end
end
