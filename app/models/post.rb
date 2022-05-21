class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性
  belongs_to :category

  #仕様変更したから後ほど解除
  # def total_price
  #   traffic + food + category_price
  # end
end
