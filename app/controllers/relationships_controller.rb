class RelationshipsController < ApplicationController
  # request.referer 遷移する前のURL（HTTPリファラ）を取得し、リダイレクトさせています。
  # フォロー処理
  def create
    @current_user.follow(params[:id])
    redirect_to request.referer
  end

  # フォロー解除処理
  def destroy
    @current_user.unfollow(params[:id])
    redirect_to request.referer
  end
end
