class C11 < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :traffic, :integer, default: 0
    change_column :posts, :food, :integer, default: 0
  end
end
