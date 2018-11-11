class RemoveUserIdFromPayment < ActiveRecord::Migration[5.2]
  def up
    remove_reference :payments, :user, index: true, foreign_key: true
  end

  def down
    add_reference :payments, :user, index: true, foreign_key: true
  end
end
