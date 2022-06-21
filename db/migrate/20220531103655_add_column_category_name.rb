class AddColumnCategoryName < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :category_name, :string
  end
end
