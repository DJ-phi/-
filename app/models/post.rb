class Post < ApplicationRecord
  belongs_to :user #リレーション, userは1の関係性
  belongs_to :category
  has_many :likes
  has_one_attached :image #アクティブストレージを使うための記述

  #ばりでーしょん
  validates :price, numericality: { only_integer: true }

  #検索機能
  def self.search(search)
    if search
      #数字の検索は文字列にしないとエラーになるcast(price as text)でテキストに変換されている
      Post.joins(:category).where( 'cast(use_day as text) LIKE ? OR cast(price as text) LIKE ? OR memo LIKE ? OR name LIKE ?',  "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%" )
    else
      Post.all
    end
  end

  #スコープ
  # scope :
  # scope :young, -> { where("age < 20") }
end

# Room.where(['room_name LIKE ? OR room_area LIKE ? OR room_memo LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%"])参考文
# @books = Book.page(params[:page]).per(100).where('genre1 LIKE ?', "%#{params[:genre1]}%").where('genre2 LIKE ?', "%#{params[:genre2]}%")...
# @books = Book.page(params[:page]).per(100).where('cast(genre1 as text) LIKE ?', "%#{params[:genre1]}%").where('genre2 LIKE ?', "%#{params[:genre2]}%")...
