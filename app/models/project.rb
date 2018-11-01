class Project < ApplicationRecord
  belongs_to :client

  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/

  validates :name, presence: :true, uniqueness: { case_sensitive: false }, format: { with: VALID_NAME_REGEX }, length: {minimum: 5, maximum: 30}
end
