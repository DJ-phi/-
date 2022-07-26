User.seed do |s|
  s.id = 1
  s.name = "猫さん"
  s.email = "test@example.com"
  s.password = 1234
  end

# 複数で書きたい時の記述
# idを入れないで生成すると自動で123...と作ってくれることを確認した
# 10.times do |n|
#   User.seed do |s|
#     s.name = "テスト名前#{n}"
#     s.email = "aaa#{n}@gmail.com"
#     s.password = "123456"
#   end
# end
