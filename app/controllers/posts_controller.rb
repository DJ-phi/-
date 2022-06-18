class PostsController < ApplicationController

  before_action :set_post, only: [ :edit, :update, :destroy ] #findをメソッド化している
  #ログイン状態じゃないと見れないページ, application_controller.rbに記述がある
  before_action :authenticate_user
  #正しいユーザーかを確かめるメソッド ログインしてるIDとひとしくないと編集できない様にしてる
  before_action :ensure_correct_post, only: [ :edit, :update, :destroy ]

  def index
    #all以外に何かくっつける場合はallはいらないです
    #order(use_day: "DESC")で並び替え
    @posts = @current_user.posts.eager_load_category.keyword(params[:keyword]).prices(params[:prices]).use_day(params[:use_day], params[:end_day]).order(use_day: "DESC")
  end

  def new
    @post = Post.new
    @categories = @current_user.categories
    #ここでidを選択する事によってラジオボタンが選択されているようになる
    #仕組みは検証のvalueの値と一致していれば選択されるようになっている
    @post.category_id = @categories.first.id
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿できました"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @categories = @current_user.categories
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "更新しました"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to posts_path
  end

  def new_category
    #Category.newは受け皿, paramsはフォームで送った文を取得, ストロングパラメータは許可したいカラムのみ
    #今回だとuser_idはログインしてるidで登録したいので弾く
    @category = Category.new(params.require(:category).permit(:name))
    @category.user_id = @current_user.id
    @category.save
    @post = Post.new(params.require(:post).permit(:memo, :price, :use_day))
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # マージメソッドでuser_idを上書きしている
    params.require(:post).permit(:memo, :user_id, :category_id, :price, :use_day, :image, :category_name).merge(user_id: @current_user.id)
  end

  def ensure_correct_post
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end
end
