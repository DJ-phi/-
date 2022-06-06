class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_one_attached :image #アクティブストレージを使うための記述

  #ばりでーしょん
  validates :price, numericality: { only_integer: true }

  #スコープ
  # scope :price, -> (price){ where('cast(price as text) = ? ', "#{price}")} 参考文 スコープで使用する場合引数を渡す必要がある
  #↑引数
  scope :keyword, ->(keyword) { where('memo LIKE ?', "%#{keyword}%") if keyword.present? }

  #曖昧検索は%を外す
  #完全一致検索    =   を使う
  scope :price, ->(price) { where('price  = ? ', price) if price.present? }

  #元は"#{use_day}", "#{end_day}"だったがruboの警告でto_sに変更
  scope :use_day, ->(use_day, end_day) { where("use_day BETWEEN ? AND ? ", use_day.to_s, end_day.to_s) if use_day.present? && end_day.present? }
end
