class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ] #findをメソッド化している

  #ログイン状態じゃないと見れないページ
  before_action :authenticate_user

  #正しいユーザーかを確かめるメソッド ログインしてるIDとひとしくないと編集できない様にしてる
  before_action :ensure_correct_category, only: [:edit, :update, :destroy]

  def index
    @categories = @current_user.categories
  end

  def new
    @category = Category.new
  end

  def create
    #複雑だったから解説入れ, Post.newで受け皿ができて
    #category_paramsで送られた情報を格納されて@category.user_id = @current_user.idでnillを上書きしてセーブしている
    #category.user_id = @current_user.idドライ化してset_post_user_idメソッドに変更
    @category = Category.new(category_params)
    set_category_user_id
    if @category.save
      flash[:notice] = "投稿できました"
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "更新しました"
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "削除しました"
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :post_id)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_category_user_id
    @category.user_id = @current_user.id
  end

  def ensure_correct_category
    if @current_user.id != @category.user_id
      flash[:notice] = "権限がありません"
      redirect_to categories_path
    end
  end
end
