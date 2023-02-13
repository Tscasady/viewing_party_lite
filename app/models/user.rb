# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :hosted_parties, class_name: 'ViewingParty', foreign_key: 'host_id'
  has_many :viewing_party_users
  has_many :invited_parties, through: :viewing_party_users, source: :viewing_party

  validates_presence_of :name, :password_digest
  validates :email, uniqueness: true, presence: true

  def display_name
    "#{name} (#{email})"
  end
end
