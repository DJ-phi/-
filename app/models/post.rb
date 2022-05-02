class Post < ApplicationRecord
  # belongs_to :user #リレーション, userは1の関係性

  def total_price
    traffic + food
  end
end
