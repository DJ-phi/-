class AddColmunUserIdTweetId < ActiveRecord::Migration[6.1]
  def change
    add_column :tweet_likes, :user_id, :integer
    add_column :tweet_likes, :tweet_id, :integer
  end
end
