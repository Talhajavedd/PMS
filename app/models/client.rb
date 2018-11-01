class Client < ApplicationRecord
  has_many :projects, dependent: :destroy

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/

  validates :name, presence: :true, uniqueness: { case_sensitive: false }, format: { with: VALID_USERNAME_REGEX }, length: {minimum: 5, maximum: 30}
  validates :company, presence: :true, length: {minimum: 5, maximum: 30}, format: { with: VALID_USERNAME_REGEX }
end
