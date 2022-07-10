class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweet_likes, dependent: :destroy

  validates :content, length: { maximum: 50 }, presence: true
end
