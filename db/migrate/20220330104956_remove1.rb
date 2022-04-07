class Remove1 < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :traffic, :integer
    remove_column :users, :food, :integer
    remove_column :users, :use_day, :datetime
    remove_column :users, :count_price, :integer
  end
end
