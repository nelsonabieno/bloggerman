class ChangePostsLikeUnlikeToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :like, :integer, default: 0
    change_column :posts, :unlike, :integer, default: 0
  end
end
