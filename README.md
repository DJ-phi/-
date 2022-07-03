# 家計簿アプリ
  自分の出費を記録してどのぐらい出費したかわかるようにできるアプリです<br>
  データ化する事によって自分の出費がどのぐらいか把握できる様に、、、<br>
  あなたの無駄遣いを救いたい<br>
  出費を登録、編集、削除ができます<br>
  明細一覧に使った合計額が表示されます<br>
  使った出費をカテゴリで分けて管理できます<br>
  特に難しい操作は無く、どの年代でも使えます<br>
  自分自身、家計簿アプリを使用しており、自分でも開発してみたいという考えで開発をしてみました<br>
  開発してく中で理解力が深まりRubyが大好きになりました
  
# アプリのurl
  https://my--kakeibo.herokuapp.com/<br>
  ゲストデータが用意してあります<br>
  email: test@gmail.com<br>
  password: 1234<br>
  ログインに成功したら明細の登録をしていただき挙動を確認ください
  
# 気になったエラーをQiitaの記事に書きました
  https://qiita.com/djedmphi/items/d2619e6634a79edcf7fc<br>
  https://qiita.com/djedmphi/items/0a92423d20a212f38028
  
# デプロイ先
  Heroku
  
# 使用書
  1. 会員登録をしてください<br>
  2. 登録が完了しましたらマイページに移ります
  3. 明細を登録するで自分の出費を登録できます
  4. カテゴリ一覧でカテゴリが管理できます
  5. つぶやき広場で悩みなど書けます
  
# ER図
  <img width="868" alt="スクリーンショット 2022-07-03 16 35 44" src="https://user-images.githubusercontent.com/94509379/177030032-b16348fe-3e6d-4f00-9c1d-e9683a4d79e6.png">
  
# 目指した課題
  目標に対して迅速に作れることを意識して作りました<br>
  開発期間は3ヶ月です<br>
  綺麗なコードを心掛けました
  
# これから実装予定
  家族で1つの家計簿を管理する機能を追加予定<br>
  相当な難易度らしいですがレベルアップのため挑戦します<br>
  
  カレンダー機能
  
# こだわったところ
  **1. カテゴリの追加を非同期処理(ajax)にした**
  
  非同期は今後通る道だと考え挑戦してアドバイスを貰いながらなんとか実装出来ました!!<br>
  複雑なjsを書いてます<br>
  自分の使っているアプリにはない機能でposts/newから非同期でcategoryが追加できるのが強みです。<br>
  自分にとって傑作です<br>
___
  **2. ログイン機能**

  ログインの理解力を深めったかったのでdevideじゃない実装をしてみました!!<br>
  deviseだとワンコマンドで出来てしまう為、中の処理がフワフワだったのですが自分で作る事により、理解力がより一層深まりました<br>
  deviseが如何に便利か思い知らされました
___
  **3. 検索機能**

  スコープをガンガン使用して<br>
  データの取り出しをしてみました<br>
  whereがない分、コードがとても見やすいです<br>
  何月何日からの間検索ができます<br>
  ```
  models/post.rb
  
    scope :eager_load_category, -> { eager_load(:category) }
    scope :keyword, ->(keyword) { where('memo LIKE ?', "%#{keyword}%") if keyword.present? }
    scope :prices, ->(price) { where('price = ? ', price) if price.present? }
    scope :use_day, ->(use_day, end_day) { where("use_day BETWEEN ? AND ? ", use_day.to_s, end_day.to_s) if use_day.present? && end_day.present? }
  ```
___
  **4. TDD開発**

  TDD開発が主流と聞いたので初めはテストから書きました！<br>
  itを書いていく中、あれが足りない、これが足りないなど気づけることが出来たのでかなり恩恵を感じました<br>
___
  **5. S3に画像を保存**

  AWSの使用が今後必ず訪れると分かったのでローカル、herokuで画像が保存される設定をしました
___
  **6. ブックマーク機能(ajax)**

  ついでにブックマークもajaxしてみました<br>
  将来的には、jsonを返却するAPIに変更し、フロントエンドもこれに対応する。
___
# 実装した機能

  **1. 明細登録機能(posts)+画像登録**
 
 一覧ページでは合計額、件数が表示されるようにしています<br>
 使った出費の値段+画像+日付+メモ+カテゴリーの登録ができるようになってます<br>
 登録、編集、削除ができます<br>
 <img width="891" alt="スクリーンショット 2022-07-03 16 58 40" src="https://user-images.githubusercontent.com/94509379/177030768-5967b30b-4ce0-409b-b504-445b819ffe82.png">
___
  **2. ログイン機能(users)**
  
  ユーザーの登録、編集、退会ができます<br>
  <img width="575" alt="スクリーンショット 2022-06-30 0 40 48" src="https://user-images.githubusercontent.com/94509379/176478587-b932d156-f491-4288-b41c-d4902c43096e.png">
___
  **3. カテゴリー管理機能**
  
  使った出費のカテゴリを登録、編集、削除ができます<br>
  <img width="296" alt="スクリーンショット 2022-06-30 0 47 11" src="https://user-images.githubusercontent.com/94509379/176479991-af4ebed6-7aa1-4fd0-a281-cf6bcfb17e38.png">
___
  **4. ブックマーク機能**
  <img width="141" alt="スクリーンショット 2022-06-30 0 50 51" src="https://user-images.githubusercontent.com/94509379/176480773-35b18f2f-31fa-4973-a8bb-55551e48c3bc.png">
___
  **5. 検索機能**
  
  キーワード検索: メモをキーワード検索できます<br>
  完全一致検索: 値段を検索できます　※完全一致した明細しか検索できません<br>
  間検索: 使った日付の間を検索できます<br>
  <img width="756" alt="スクリーンショット 2022-06-30 0 53 14" src="https://user-images.githubusercontent.com/94509379/176481223-96ebe737-e342-489b-abe5-6c2a6bdc12ca.png">
___
  **6. つぶやき機能**
  
  つぶやける広場を実装してみました<br>
  2chみたいな作りにしました<br>
  <img width="534" alt="スクリーンショット 2022-07-03 16 41 52" src="https://user-images.githubusercontent.com/94509379/177030247-168d1efc-998e-4ff4-a0fd-afdf1bdde91b.png">
___
## 使用環境
  - M1 mac
  - Ruby 3.1.0
  - PostgreSQL 14.2
  - RuboCop
  - AWS S3
  - Rails 6.1.4
  
# テーブル設計
  **userテーブル**

```
schema.rb

create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end
```

  **アソシエーション**

```
models/post.rb

has_many :posts, dependent: :destroy
has_many :categories, dependent: :destroy
has_many :likes, dependent: :destroy
```
---
  **categoryテーブル**
  
```
schema.rb

create_table "categories", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.integer "user_id"
end
```
  
  **アソシエーション**
  
```
models/category.rb

has_many :posts, dependent: :destroy
belongs_to :user
```
---
  **postテーブル**
  
```
schema.rb

create_table "posts", force: :cascade do |t|
  t.integer "user_id"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.string "memo"
  t.integer "category_id"
  t.integer "price", default: 0
  t.date "u
end
```

  **アソシエーション**

```
models/post.rb

belongs_to :user
belongs_to :category
has_many :likes, dependent: :destroy
has_one_attached :image

```
---
  **likeテーブル**
  
```
schema.rb

create_table "likes", force: :cascade do |t|
  t.integer "user_id"
  t.integer "post_id"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end
```

**アソシエーション**

```
models/like.rb

 belongs_to :user
 belongs_to :post
```
---
  **tweetテーブル**
  
 ```
 schema.rb
 
 create_table "tweets", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
 ```
 
 **アソシエーション**

```
models/tweet.rb

belongs_to :user
```

  
  
