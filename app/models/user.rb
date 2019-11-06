class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  validates :nickname, length: { minimum: 5 }, presence: true
  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
            presence: true,
            uniqueness: true
  validates :password_digest, length: { minimum: 5 }, presence:true
  validates :password, presence:true
  validates :password, confirmation: { case_sensitive: true }
end
