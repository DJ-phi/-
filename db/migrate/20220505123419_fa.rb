class Fa < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :use_day, :datetime
  end
end
