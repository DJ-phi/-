class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性
  belongs_to :category
  has_many :likes
  has_one_attached :image #アクティブストレージを使うための記述

  #ばりでーしょん
  validates :price, numericality: { only_integer: true }

  #検索機能
  def self.search(keyword, price, created_at)
    if keyword
      #数字の検索は文字列にしないとエラーになるcast(price as text)でテキストに変換されている
      Post.joins(:category).where('memo LIKE ?', "%#{keyword}%")
    elsif price
      Post.joins(:category).where('cast(price as text) LIKE ?', "%#{price}%")
    elsif created_at
      Post.where('created_at(price as text) LIKE ?', "%#{created_at}%")
    else
      Post.all
    end
  end

  #スコープ
  # scope :
  # scope :young, -> { where("age < 20") }
end

# Post.joins(:category).where( 'cast(created_at as text) LIKE ? OR cast(use_day as text) LIKE ? OR cast(price as text) LIKE ? OR memo LIKE ? OR name LIKE ?',  "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%" )
