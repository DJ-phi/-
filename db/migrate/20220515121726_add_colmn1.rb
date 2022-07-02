class AddColmn1 < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :use_day, :datetime
  end
end
