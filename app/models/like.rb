class Like < ApplicationRecord
  # TODO: pikawaka参考
  # counter_cacheはアソシエーションした時に使えるオプション
  # sizeを使用する事によってsqlの発行をしないで済む
  # いいねを押すと-1になってしまう
  belongs_to :user, counter_cache: :likes_count
  belongs_to :post, counter_cache: :likes_count
end
