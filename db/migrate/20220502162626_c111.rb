class C111 < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :traffic, :integer, null: true, default: 0
    change_column :posts, :food, :integer, null: true, default: 0
  end
end
