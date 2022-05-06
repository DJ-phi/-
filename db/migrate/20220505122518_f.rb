class F < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :use_day, :datetime
  end
end
