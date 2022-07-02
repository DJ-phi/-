class AddColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :category_price, :integer
  end
end
