# 家計簿アプリ

自分の出費を記録してどのぐらい出費したかわかるようにできるアプリです。

データ化する事によって自分の出費がどのぐらいか把握できる様に、、、

あなたの無駄遣いを救いたい。

出費を登録、編集、削除ができます。

明細一覧に使った合計額が表示されます。

使った出費をカテゴリで分けて管理できます。

特に難しい操作は無く、どの年代でも使えます。

自分自身、家計簿アプリを使用しており、自分でも開発してみたいという考えで開発をしてみました。

開発してく中で理解力が深まりRubyが大好きになりました。

# アプリのurl

<https://my--kakeibo.herokuapp.com/>

ゲストデータが用意してあります。

email: test@example.com
password: 1234

Git cloneした場合
ターミナルに以下のコマンドでゲストデータが作れます
$ rails db:seed_fu

ログインに成功したら明細の登録をしていただき挙動を確認ください。

# デプロイ先

Heroku

# 仕様書

1. 会員登録をしてください。
2. 登録が完了しましたらマイページに移ります。
3. 明細を登録するで自分の出費を登録できます。
4. カテゴリ一覧でカテゴリが管理できます。

# ER図

<img width="1180" alt="スクリーンショット 2022-07-23 13 50 05" src="https://user-images.githubusercontent.com/94509379/180590929-b948a174-3083-4f81-981e-415b2de54398.png">

# 目指した課題

目標に対して迅速に作れることを意識して作りました。
開発期間は3ヶ月です。
綺麗なコードを心掛けました。

# これから実装予定

家族で1つの家計簿を管理する機能を追加予定。
相当な難易度らしいですがレベルアップのため挑戦します。

カレンダー機能

# こだわったところ

## カテゴリの追加を非同期処理(ajax)にした

非同期は今後通る道だと考え挑戦してアドバイスを貰いながらなんとか実装出来ました!!
複雑なjsを書いてます。
自分の使っているアプリにはない機能でposts/newから非同期でcategoryが追加できるのが強みです。
自分にとって傑作です。

<img width="1347" alt="スクリーンショット 2022-07-26 15 23 26" src="https://user-images.githubusercontent.com/94509379/180937819-9a4e8896-8f7d-47a2-9e6a-6a8e1e21c463.png">

## ログイン機能

ログインの理解力を深めったかったのでdevideじゃない実装をしてみました!!
deviseだとワンコマンドで出来てしまう為、中の処理がフワフワだったのですが自分で作る事により、理解力がより一層深まりました。
deviseが如何に便利か思い知らされました。

## 検索機能

スコープをガンガン使用して
データの取り出しをしてみました。
whereがない分、コードがとても見やすいです。
何月何日からの間検索ができます。

<img width="881" alt="スクリーンショット 2022-07-26 15 20 10" src="https://user-images.githubusercontent.com/94509379/180937479-0ec94e1d-905f-4005-a685-ec894a6b6d41.png">

## TDD開発

TDD開発が主流と聞いたので初めはテストから書きました！
itを書いていく中、あれが足りない、これが足りないなど気づけることが出来たのでかなり恩恵を感じました。
## S3に画像を保存

AWSの使用が今後必ず訪れると分かったのでローカル、herokuで画像が保存される設定をしました。
## ブックマーク機能(ajax)

ついでにブックマークもajaxしてみました。
将来的には、jsonを返却するAPIに変更し、フロントエンドもこれに対応する。

# 実装した機能

## 明細登録機能(posts)+画像登録

一覧ページでは合計額、件数が表示されるようにしています。
使った出費の値段+画像+日付+メモ+カテゴリーの登録ができるようになってます。
登録、編集、削除ができます。

<img width="1264" alt="スクリーンショット 2022-06-30 0 37 05" src="https://user-images.githubusercontent.com/94509379/176477808-37b04831-38b9-464e-9c11-1182b5b11c26.png">

## ログイン機能(users)

ユーザーの登録、編集、退会ができます。

<img width="575" alt="スクリーンショット 2022-06-30 0 40 48" src="https://user-images.githubusercontent.com/94509379/176478587-b932d156-f491-4288-b41c-d4902c43096e.png">

## カテゴリー管理機能

使った出費のカテゴリを登録、編集、削除ができます。

<img width="296" alt="スクリーンショット 2022-06-30 0 47 11" src="https://user-images.githubusercontent.com/94509379/176479991-af4ebed6-7aa1-4fd0-a281-cf6bcfb17e38.png">

## ブックマーク機能

<img width="141" alt="スクリーンショット 2022-06-30 0 50 51" src="https://user-images.githubusercontent.com/94509379/176480773-35b18f2f-31fa-4973-a8bb-55551e48c3bc.png">

## 検索機能

- キーワード検索: メモをキーワード検索できます。
- 完全一致検索: 値段を検索できます ※完全一致した明細しか検索できません。
- 日付検索: 使った日付の間を検索できます。

<img width="756" alt="スクリーンショット 2022-06-30 0 53 14" src="https://user-images.githubusercontent.com/94509379/176481223-96ebe737-e342-489b-abe5-6c2a6bdc12ca.png">

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
has_many :post_likes, dependent: :destroy
has_many :tweet_likes, dependent: :destroy
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
has_many :post_likes, dependent: :destroy
has_one_attached :image

```

---
**post_likeテーブル**

```
schema.rb

create_table "likes", force: :cascade do |t|
create_table "post_likes", force: :cascade do |t|
t.integer "user_id"
t.integer "post_id"
t.datetime "created_at", precision: 6, null: false
t.datetime "updated_at", precision: 6, null: false
end
```

**アソシエーション**

```
models/post_like.rb

belongs_to :user
belongs_to :post
```
---
**tweetテーブル**

```
schema.rb

create_table "tweets", force: :cascade do |t|
t.integer "user_id"
t.datetime "created_at", precision: 6, null: false
t.datetime "updated_at", precision: 6, null: false
end
```

**アソシエーション**

```
models/tweet.rb

belongs_to :user
has_many :tweet_likes, dependent: :destroy

validates :content, length: { maximum: 50 }, presence: true
```
---
**tweet_like**

```
schema.rb

create_table "tweet_likes", force: :cascade do |t|
t.datetime "created_at", precision: 6, null: false
t.datetime "updated_at", precision: 6, null: false
t.integer "user_id"
t.integer "tweet_id"
end
```
---
**tweet_like**

**アソシエーション**

```
models/tweet_like.rb

belongs_to :user
belongs_to :tweet
```
---
**Relationship(中間テーブル)**

```
schema.rb

create_table "relationships", force: :cascade do |t|
t.integer "follower_id"
t.integer "followed_id"
t.datetime "created_at", precision: 6, null: false
t.datetime "updated_at", precision: 6, null: false
end

```

**アソシエーション**

```
models/relationship.rb

belongs_to :follower, class_name: "User"
belongs_to :followed, class_name: "User"
```
