class ApplicationController < ActionController::Base

  before_action :set_current_user

  def set_current_user
    # ページを移動してもユーザー情報を保持し続けるために、sessionという特殊な変数を用います。
    # sessionに代入された値は、ブラウザ(InternetExplorer, GoogleChrome等)に保存されます。
    # sessionに値を代入すると、ブラウザはそれ以降のアクセスでsessionの値をRailsに送信します。
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def forbid_login_user
    if @current_user
      #TODO:この記述じゃないとエラーになる
      redirect_to user_path(@current_user)
    end
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to user_path(@user)
    end
  end

  def ensure_correct_post
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end

  def ensure_correct_category
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to categoris_path
    end
  end
end
