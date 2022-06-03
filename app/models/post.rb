class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性
  belongs_to :category
  has_many :likes
  has_one_attached :image #アクティブストレージを使うための記述

  #ばりでーしょん
  validates :price, numericality: { only_integer: true }

  #検索機能
  def self.search(keyword, price, use_day, end_day)
    if keyword.present?
      #数字の検索は文字列にしないとエラーになるcast(price as text)でテキストに変換されている
      Post.joins(:category).where('memo LIKE ?', "%#{keyword}%")
    elsif price.present?
      Post.joins(:category).where('cast(price as text) LIKE ?', "%#{price}%")
    elsif use_day.present? && end_day.present?
      Post.where("use_day BETWEEN ? AND ? ", "#{use_day}", "#{end_day}")
      # WHERE カラム名 BETWEEN 日付 AND 日付」で指定した2つの日付期間内のデータを取得します。
    else
      Post.all
    end
  end
end

# Post.joins(:category).where( 'cast(created_at as text) LIKE ? OR cast(use_day as text) LIKE ? OR cast(price as text) LIKE ? OR memo LIKE ? OR name LIKE ?',  "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%" )
