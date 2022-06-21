10.times do |n|
  Category.seed do |s|
    s.name = "テスト名前#{n}"
    s.user_id = 1
  end
end
