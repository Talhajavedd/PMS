class ModifyUsernameColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :username, :string, null: false, limit: 30
  end
end
