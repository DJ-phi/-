class User < ApplicationRecord
  validates :name,{presence:true}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum: 4, maximum: 10 }
  has_many :posts, dependent: :destroy #リレーション,postsが多の関係性,dependent: :destroyはそのモデル(user)が削除されたら、紐づいているモデル(posts)も削除するというもの
end
