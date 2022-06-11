class UsersController < ApplicationController

  #@user = User.find(params[:id])をメソッド化している
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  #ログイン状態じゃないと見れないページ, application_controller.rbに記述がある
  before_action :authenticate_user, only: [ :index, :show, :edit, :update ] 

  #ログイン状態のページ制限, application_controller.rbに記述がある
  before_action :forbid_login_user, only: [ :new, :create, :login_form, :login ]

  #正しいユーザーかを確かめるメソッド ログインしてるIDとひとしくないと編集できない様にしてる, application_controller.rbに記述がある
  before_action :ensure_correct_user, only: [:edit, :update, :destroy] 

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

  def ensure_correct_user
    if @current_user.id != @user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(@current_user)
    end
  end
end
