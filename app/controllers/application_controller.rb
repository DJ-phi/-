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
      #showに飛ばしたい時は@current_userが主流
      redirect_to user_path(@current_user)
    end
  end
end
