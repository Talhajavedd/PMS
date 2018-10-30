class ChangeUserStatusColumnName < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :users, :status, :enable
  end

  def self.down
    rename_column :users, :enable, :status
  end
end
