class RemoveColmunPostId < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :post_id, :integer
  end
end
