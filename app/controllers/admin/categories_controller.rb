class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.roots
                          .page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
  end

  def new
    @root_categories = Category.roots.order('id desc')
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit!)
    if @category.save
      flash[:notice] = '新建分类成功！'
      redirect_to admin_categories_path
    else
      flash[:notice] = "新建分类失败！"
      @root_categories = Category.roots.order('id desc')
      render action: :new
    end
  end
end
