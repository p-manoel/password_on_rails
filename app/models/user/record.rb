# frozen_string_literal: true

module User
  class Record < ApplicationRecord
    self.table_name = 'users'
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    has_many :user_passwords, class_name: '::UserPassword::Record', dependent: :destroy
    has_many :passwords, class_name: '::Password::Record', through: :user_passwords
  end
end
