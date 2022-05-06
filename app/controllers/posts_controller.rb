class PostsController < ApplicationController

  before_action :set_post, only: [ :show, :edit, :update, :destroy ] #findをメソッド化している
  before_action :authenticate_user #ログイン状態じゃないと見れないページ

  def index
    console
    @posts = Post.all
  end

  def new
    # console
    @post = Post.new
  end

  def create
    #複雑だったから解説入れ, Post.newで受け皿ができて
    #post_paramsで送られた情報を格納されて@post.user_id = @current_user.idでnillを上書きしてセーブしている
    #post.user_id = @current_user.idドライ化してset_post_user_idメソッドに変更
    @post = Post.new(post_params)
    set_post_user_id
    if @post.save
      flash[:notice] = "投稿できました"
      redirect_to user_path(@post.user_id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "更新しました"
      redirect_to user_path(@post.user_id)
    else
      render :edit
    end
  end

  def destroy
    set_post_user_id
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to user_path(@post.user_id)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :food, :traffic, :user_id)
  end

  private
  
  def set_post_user_id
    @post.user_id = @current_user.id
  end
end
