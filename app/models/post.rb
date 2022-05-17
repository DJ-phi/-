class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性

  validates :price, numericality: { only_integer: true }

  #TODO:仕様が変わったのでとりあえずコメントアウト
  # def total_price
  #   traffic + food
  # end
end
