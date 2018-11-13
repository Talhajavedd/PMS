class CreateJoinTableUserProject < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :users do |t|
      t.index %i[project_id user_id]
      t.index %i[user_id project_id]
    end
  end
end
