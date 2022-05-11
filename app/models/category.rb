class Category < ApplicationRecord
  validates :name,{presence:true}
  has_many :posts
  belongs_to :user, optional: true
end
