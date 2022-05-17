class Post < ApplicationRecord
  belongs_to :user, optional: true #リレーション, userは1の関係性, optional: trueとはbelongs_toの外部キーのnilを許可するというもの
  belongs_to :category, optional: true
  # validates :traffic, :food, format: { with: /\A[0-9]+\z/ }

  #仕様変更したから後ほど解除
  # def total_price
  #   traffic + food + category_price
  # end
end
