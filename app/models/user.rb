class User < ApplicationRecord
  # users テーブルにパスワードを保存するとき、パスワードを暗号化して保存してくれる
  has_secure_password

  #{}があると
  #undefined method `to_sym' for {:presence=>true}:Hashエラー文が出てしまう
  validates :name, presence:true, uniqueness: true, length: { maximum: 10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum: 4, maximum: 10 }

  #リレーション,postsが多の関係性,dependent: :destroyはそのモデル(user)が削除されたら、紐づいているモデル(posts)も削除するというもの
  has_many :posts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :tweets, dependent: :destroy

  # いいね
  has_many :post_likes, dependent: :destroy
  has_many :tweet_likes, dependent: :destroy

  # フォロー
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # ① フォローしている人取得(Userのfollowerから見た関係)
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # ② フォローされている人取得(Userのfolowedから見た関係)
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人(自分がフォローされている人)

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォロー確認をおこなう
  def following?(user)
    following_user.include?(user)
  end

  # いいねの判定
  def post_liked_by?(post_id)
    post_likes.where(post_id: post_id).exists?
  end

  def tweet_liked_by?(tweet_id)
    tweet_likes.where(tweet_id: tweet_id).exists?
  end
end
