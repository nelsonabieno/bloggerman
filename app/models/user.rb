class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :nickname, length: { minimum: 5 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: { minimum: 5 }
end
