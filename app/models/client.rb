class Client < ApplicationRecord

  validates :name, presence: :true, uniqueness: { case_sensitive: false }
  validates :company, presence: :true
end
