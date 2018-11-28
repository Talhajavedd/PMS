class Payment < ApplicationRecord
  belongs_to :project

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 999999999 }

  paginates_per 10
end
