class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy] #findをメソッド化している
  # before_action :authenticate_user 後ほど解放

  def index
    console
    @posts = Post.all
  end

  def new
    console
    @post = Post.new
  end

  def create
    #複雑だったから解説入れ, Post.newで受け皿ができて
    #post_paramsで送られた情報を格納されて@post.user_id = @current_user.idでnillを上書きしてセーブしている
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save
      flash[:notice] = "投稿できました"
      redirect_to post_path(@post.id)
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

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :food, :traffic)
  end
end
