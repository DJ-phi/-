class ChangeColmnUseDay < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :use_day, :date
  end
end
