class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性
  belongs_to :category
  has_one_attached :image #アクティブストレージを使うための記述

  #仕様変更したから後ほど解除
  # def total_price
  #   traffic + food + category_price
  validates :price, numericality: { only_integer: true }
end
