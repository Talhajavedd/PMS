class Payment < ApplicationRecord
  belongs_to :project

  validates :amount, presence: :true, numericality: { only_integer: true }
end
