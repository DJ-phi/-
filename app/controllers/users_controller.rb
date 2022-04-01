class UsersController < ApplicationController
  def index
    @users = User.all

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    @user.save
    flash[:notice] = "ユーザー登録が完了しました"
    redirect_to("/users/#{@user.id}")
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :email, :password))
      flash[:notice] = "更新しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy

  end
end
