class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    # Railsアプリケーションではユーザごとにセッションが設定されます。
    # その中に、前のリクエストの情報を次のリクエスでも利用できるよう小さなデータを保存することができます。
    # このセッションデータの保存先には幾つか種類がありますが、デフォルトではクライアント側のブラウザCookieに保存する方法が取られます。
    # なお、Cookieは暗号化され、保存形式もハッシュを模しており扱いやすいです。
    # そして、このセッションの保存領域を簡単に制御できるように用意されたのがSessionメソッドなるものです。（多分）
    # ページを移動してもユーザー情報を保持し続けるために、sessionという特殊な変数を用います。
    # sessionに代入された値は、ブラウザ(InternetExplorer, GoogleChrome等)に保存されます。
    # sessionに値を代入すると、ブラウザはそれ以降のアクセスでsessionの値をRailsに送信します。
    # session[:キー名]というのはこれに代入した情報を送信し続ける変数です
    # (ここではユーザーの情報を送信することでページを移動しても情報が保持されログイン状態が続くという仕組み)
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user.nil?
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def forbid_login_user
    if @current_user
      # showに飛ばしたい時は@current_userが主流
      redirect_to user_path(@current_user)
    end
  end
end
