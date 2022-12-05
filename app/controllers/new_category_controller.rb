class NewCategoryController < ApplicationController
  
  # TODO: 恐らく削除
  def new_category
    # Category.newは受け皿, paramsはフォームで送った文を取得, ストロングパラメータは許可したいカラムのみ
    # 今回だとuser_idはログインしてるidで登録したいので弾く
    @category = Category.new(params.require(:category).permit(:name))
    @category.user_id = @current_user.id
    @category.save
    @post = Post.new(params.require(:post).permit(:memo, :price, :use_day))
  end
end
