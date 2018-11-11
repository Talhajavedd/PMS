class Project < ApplicationRecord
  belongs_to :client
  has_many :payments, dependent: :destroy
  has_many :time_logs, dependent: :destroy

  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/.freeze

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_NAME_REGEX }, length: { minimum: 5, maximum: 30 }
end
