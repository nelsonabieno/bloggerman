class RenameCommentsUsersIdToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :users_id, :user_id
  end
end
