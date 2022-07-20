class C1 < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :use_day, :integer
    remove_column :posts, :count_price, :integer
    change_column :posts, :traffic, :integer, null: false, default: 0
    change_column :posts, :food, :integer, null: false, default: 0
  end
end
