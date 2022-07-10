class User < ApplicationRecord
  #{}があると
  #undefined method `to_sym' for {:presence=>true}:Hashエラー文が出てしまう
  validates :name, presence:true, uniqueness: true, length: { maximum: 10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum: 4, maximum: 10 }

  #リレーション,postsが多の関係性,dependent: :destroyはそのモデル(user)が削除されたら、紐づいているモデル(posts)も削除するというもの
  has_many :posts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :tweet_likes, dependent: :destroy

  def post_liked_by?(post_id)
    post_likes.where(post_id: post_id).exists?
  end

  def tweet_liked_by?(tweet_id)
    tweet_likes.where(tweet_id: tweet_id).exists?
  end
end
