Post.seed do |s|
  s.memo = "レッドプル"
  s.price = 200
  s.user_id = 1
  s.category_id = 1
  end

  Post.seed do |s|
    s.memo = "パン"
    s.price = 300
    s.user_id = 1
    s.category_id = 1
    end

    Post.seed do |s|
      s.memo = "本"
      s.price = 1000
      s.user_id = 1
      s.category_id = 1
      end

# 複数の記述
# 10.times do |n|
#   Post.seed do |s|
#     s.memo = "テスト名前#{n}"
#     s.price = 10
#     s.user_id = 1
#     s.category_id = 1
#   end
# end
