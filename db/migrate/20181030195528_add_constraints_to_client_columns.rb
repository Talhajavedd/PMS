class AddConstraintsToClientColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :name, :string, null: false, limit: 30
    change_column :clients, :company, :string, null: false, limit: 30
  end
end
