class ChengeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :category_price, :integer, null: true, default: 0
  end
end
