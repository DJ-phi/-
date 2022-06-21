class RemoveCategoryName < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :category_name, :string
  end
end
