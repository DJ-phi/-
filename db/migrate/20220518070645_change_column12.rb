class ChangeColumn12 < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :password, :string
  end
end
