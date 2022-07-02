class Aaaa < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :post_id, :integer
    add_column :categories, :user_id, :integer
  end
end
