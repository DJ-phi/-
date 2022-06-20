class AddColmunUserLikesCount < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :likes_count, :integer
  end
end
