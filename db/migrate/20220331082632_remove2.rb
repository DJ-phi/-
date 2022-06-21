class Remove2 < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :rails, :string
    remove_column :posts, :g, :string
    remove_column :posts, :model, :string
    remove_column :posts, :Post, :string
  end
end
