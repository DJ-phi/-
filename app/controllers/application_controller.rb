class ApplicationController < ActionController::Base

  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end

  #TODO: エラーになる
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
