Category.seed do |s|
  s.name = "交通費"
  s.user_id = 1
end

Category.seed do |s|
  s.name = "食事代"
  s.user_id = 1
end

Category.seed do |s|
  s.name = "飲み物代"
  s.user_id = 1
end

# 複数の記述
# 10.times do |n|
#   Category.seed do |s|
#     s.name = "テスト名前#{n}"
#     s.user_id = 1
#   end
# end
