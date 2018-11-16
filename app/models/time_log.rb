class TimeLog < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :hours, presence: true, numericality: { greater_than: 0, message: 'or minutes should be greater than 0' }
  validates :date, presence: true
  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    errors.add(:date, "can't be in the future") if date.present? && date > Date.today
  end

  def hours=(new_hours)
    self[:hours] = (new_hours[4] + (new_hours[5].to_f / 60.to_f))
  end

  paginates_per 10
end
