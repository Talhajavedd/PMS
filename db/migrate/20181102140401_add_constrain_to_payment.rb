class AddConstrainToPayment < ActiveRecord::Migration[5.2]
  def up
    change_column :payments, :amount, :integer, null: false
    change_column :payments, :project_id, :bigint, null: false
  end
  def down
    change_column :payments, :amount, :integer, null: true
    change_column :projects, :project_id, :bigint, null: true
  end
end
