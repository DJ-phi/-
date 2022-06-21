10.times do |n|
  Post.seed do |s|
    s.memo = "テスト名前#{n}"
    s.price = 10
    s.user_id = 1
    s.category_id = 1
  end
end
