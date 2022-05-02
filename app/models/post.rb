class Post < ApplicationRecord
  # belongs_to :user #リレーション, userは1の関係性

  validates :traffic, :food, format: { with: /\A[0-9]+\z/ }

  def total_price
    traffic + food
  end
end
