class UsersController < ApplicationController

  before_action :set_user, only: [ :show, :edit, :update, :destroy ] #@user = User.find(params[:id])をメソッド化している
  before_action :authenticate_user, only: [ :index, :show, :edit, :update ] #ログイン状態じゃないと見れないページ
  before_action :forbid_login_user, only: [ :new, :create, :login_form, :login ] #ログイン状態のページ制限
  #TODO:動作確認がしたいので後ほど解放
  # before_action :ensure_correct_user, only: [:edit, :update] 

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    #アソシエーションをしない記述
    # @posts = Post.where(user_id: @current_user.id) #whereを使う場合カラム：
    #アソシエーションをしていた場合
    @posts = @current_user.posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to users_path
  end

  def login_form

  end

  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )
    if @user 
      session[:user_id] = @user.id #ここに追加
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user.id)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  #TODO:動作確認がしたいので後ほど解放
  # 動作確認するので後ほど解放
  # def ensure_correct_user
  #   if @current_user.id != params[:id].to_i
  #     flash[:notice] = "権限がありません"
  #     redirect_to users_path 
  #   end
  # end
end
