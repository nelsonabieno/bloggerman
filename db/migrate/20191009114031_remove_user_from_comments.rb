class RemoveUserFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :users_id
  end
end
