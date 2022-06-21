# 一括で10個のユーザーデータを作成
# 10回繰り返し処理を行う
10.times do |n|
  User.create!(
    # n + 1で数字が重複しないようにする
    email: "test#{n + 1}@test.com",
    name: "テスト#{n + 1}",
    password: 12345
  )
end
