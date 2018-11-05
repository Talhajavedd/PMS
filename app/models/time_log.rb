class TimeLog < ApplicationRecord
  belongs_to :project

  validates :hours, presence: :true
  validates :date, presence: :true
  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end  

  def hours=(new_hours)
    self[:hours] = (new_hours[4] + ((new_hours[5].to_f)/60.to_f))  
  end
end
