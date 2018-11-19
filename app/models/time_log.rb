class TimeLog < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :hours, presence: true, numericality: { greater_than: 0, message: 'or minutes should be greater than 0' }
  validates :time_log, presence: true
  validates :date, presence: true
  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    errors.add(:date, "can't be in the future") if date.present? && date > Date.today
  end

  def set_hours(params)
    self[:hours] = ((params["time_log(4i)"].to_f * 60) + params["time_log(5i)"].to_f) / 60
  end

  paginates_per 5
end
