class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :rails
      t.string :g
      t.string :model
      t.string :Post
      t.integer :traffic
      t.integer :food
      t.datetime :use_day
      t.integer :count_price
      t.integer :user_id

      t.timestamps
    end
  end
end
