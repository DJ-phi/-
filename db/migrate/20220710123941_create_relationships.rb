class CreateRelationships < ActiveRecord::Migration[6.1]
  # NOT NULL制約とadd_indexを追記する。インデックスを付与すると検索速度が向上します。
  # そしてfollower_idとfollowed_idの組み合わせはユニークである必要がある。
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :users,         :id
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
