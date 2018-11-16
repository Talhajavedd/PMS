# comment
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :body, presence: true

  paginates_per 10
end
