class CreateTimeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_logs do |t|
      t.references :project, foreign_key: true, null: false
      t.datetime :date, null: false
      t.decimal :hours, precision: 4, scale: 2, null: false

      t.timestamps
    end
  end
end
