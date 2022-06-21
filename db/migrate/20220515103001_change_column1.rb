class ChangeColumn1 < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :food, :integer
    remove_column :posts, :traffic, :integer
  end
end
