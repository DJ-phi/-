class User < ApplicationRecord
  # users テーブルにパスワードを保存するとき、パスワードを暗号化して保存してくれる
  has_secure_password

  # {}があると
  # undefined method `to_sym' for {:presence=>true}:Hashエラー文が出てしまう
  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum: 4, maximum: 10 }

  # リレーション,postsが多の関係性,dependent: :destroyはそのモデル(user)が削除されたら、紐づいているモデル(posts)も削除するというもの
  has_many :posts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :tweets, dependent: :destroy

  # いいね
  has_many :post_likes, dependent: :destroy
  has_many :tweet_likes, dependent: :destroy

  # フォロー
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # いいねの判定
  def post_liked_by?(post_id)
    post_likes.exists?(post_id:)
  end

  def tweet_liked_by?(tweet_id)
    tweet_likes.exists?(tweet_id:)
  end
end
