class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(
      email: params[:email],
      password_digest: params[:password]
    )
    if @user
      session[:user_id] = @user.id # ここに追加
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user.id)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
