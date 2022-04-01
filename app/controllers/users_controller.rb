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
    redirect_to("/users/#{@user.id}")
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
