class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :traffic
      t.integer :food
      t.datetime :use_day
      t.integer :count_price
      t.integer :password

      t.timestamps
    end
  end
end
