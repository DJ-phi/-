class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :user

  validates :name,{presence:true}
end
