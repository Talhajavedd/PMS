class AddConstraintToTimeLogs < ActiveRecord::Migration[5.2]
  def up
    add_column :time_logs, :time_log, :time
  end

  def down
    add_column :time_logs, :time_log, :time
  end
end
