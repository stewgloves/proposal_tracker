# app/models/comment.rb

class Comment < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :proposal

  validates :body, presence: true
end
