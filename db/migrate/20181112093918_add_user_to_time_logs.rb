class AddUserToTimeLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :time_logs, :user, foreign_key: true
  end
end
