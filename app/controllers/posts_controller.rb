class PostsController < ApplicationController

  before_action :set_post, only: [ :edit, :update, :destroy ] #findをメソッド化している
  before_action :authenticate_user #ログイン状態じゃないと見れないページ

  def search 
    @posts =  Post.keyword(params[:keyword]).price(params[:price]).use_day(params[:use_day], params[:end_day])
  end

  def index
    console
    @posts = Post.all
    @categories = Category.all
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
      redirect_to post_path(@post.user_id)
    else
      render :new
    end
  end

  def show
    @posts = @current_user.posts
    @categories = @current_user.categories

  end

  def edit
    @categories = @current_user.categories
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "更新しました"
      redirect_to post_path(@post.user_id)
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

  def self.search(keyword, price, use_day, end_day)
    Post.keyword(keyword).price(price).use_day(use_day, end_day)
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
