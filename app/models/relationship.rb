class Relationship < ApplicationRecord
  # フォローする人(follower)もされる人(followed)もUserモデルでした。
  # 本来、followerやfollowedといったモデルは存在しません。
  # class_nameをつけることで、関連先のモデルを参照する際の名前を変更できるということです。
  # 「Userをfollowとfollowedに分ける」ことをclass_nameがやってくれるんですね。
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
