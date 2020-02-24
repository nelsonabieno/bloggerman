class Comment < ApplicationRecord
  belongs_to :post
  validates_presence_of :body
  validates_presence_of :user_id, numericality: true
  validates_presence_of :post_id, numericality: true
end
