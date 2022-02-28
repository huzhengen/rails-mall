class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
  end

  def new
    @root_categories = Category.roots
    @product = Product.new
  end

  def create
    @product = Product.new(params.require(:product).permit!)
    if @product.save
      flash[:notice] = "新增商品成功！"
      redirect_to admin_products_path
    else
      @root_categories = Category.roots
      render action: :new
    end
  end

  def edit
    @root_categories = Category.roots
    render action: :new
  end

  def update
    @root_categories = Category.roots
    if @product.update(params.require(:product).permit!)
      flash[:notice] = "修改商品成功！"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "删除商品成功！"
      redirect_to admin_products_path
    else
      flash[:notice] = "删除商品失败！"
      redirect_to :back
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

end
