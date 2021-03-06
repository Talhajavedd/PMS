class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :company

      t.timestamps
    end
    add_index :clients, :name, unique: true
  end
end
