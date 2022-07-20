class ChangeColmn1 < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :title, :memo
    rename_column :posts, :category_price, :price
  end
end
