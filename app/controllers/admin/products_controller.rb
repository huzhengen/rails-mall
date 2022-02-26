class Admin::ProductsController < Admin::BaseController

  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
  end

  def new
    @product = Product.new
    @root_categories = Category.roots

  end

  def create
    @product = Product.new(params.require(:product).permit!)
    if @product.save
      flash[:notice] = "新增商品成功！"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

end
