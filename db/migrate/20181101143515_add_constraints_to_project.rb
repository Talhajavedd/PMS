class AddConstraintsToProject < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :name, :string, null: false, limit: 30
    change_column :projects, :client_id, :bigint, null: false
    add_index :projects, :name, unique: true
  end
end
