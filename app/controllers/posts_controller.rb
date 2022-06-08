class PostsController < ApplicationController

  before_action :set_post, only: [ :edit, :update, :destroy ] #findをメソッド化している
  before_action :authenticate_user #ログイン状態じゃないと見れないページ
  
  #正しいユーザーかを確かめるメソッド ログインしてるIDとひとしくないと編集できない様にしてる, application_controller.rbに記述がある
  before_action :ensure_correct_post, only: [:edit, :update, :destroy] 

  def search 
    @posts = Post.joins_category.keyword(params[:keyword]).price(params[:price]).use_day(params[:use_day], params[:end_day])
  end

  def index
    # @posts = Post.all.includes(:category, :image_attachment)
  #TODO:未完成
  if search.present?
    @posts = Post.joins_category.keyword(params[:keyword]).price(params[:price]).use_day(params[:use_day], params[:end_day])
  end
    @posts = Post.all.includes(:category, :image_attachment)
  end

  def new
    @post = Post.new
    @categories = @current_user.categories
  end

  def create
    #複雑だったから解説入れ, Post.newで受け皿ができて
    #post_paramsで送られた情報を格納されて@post.user_id = @current_user.idでnillを上書きしてセーブしている
    #post.user_id = @current_user.idドライ化してset_post_user_idメソッドに変更
    @post = Post.new(post_params)
    set_post_user_id
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
    p @post.inspect
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:memo, :user_id, :category_id, :price, :use_day, :image, :category_name)
  end
  
  def set_post_user_id
    @post.user_id = @current_user.id
  end
end
