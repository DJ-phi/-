class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(
      email: params[:email],
      password_digest: params[:password]
    )
    # 例外処理
    if @user.nil?
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render :new
      return
    end

    # 正常処理
    session[:user_id] = @user.id # ここに追加
    flash[:notice] = "ログインしました"
    redirect_to user_path(@user.id)
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
