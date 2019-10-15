class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.references :users, :foreign_key => true
      t.string :like
      t.string :unlike
    end
  end
end

