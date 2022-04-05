class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password))
    if @user.save
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
