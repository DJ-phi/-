class Post < ApplicationRecord
  belongs_to :user, optional: true #リレーション, userは1の関係性, optional: trueとはbelongs_toの外部キーのnilを許可するというもの

  validates :traffic, :food, format: { with: /\A[0-9]+\z/ }

  def total_price
    traffic + food
  end
end
