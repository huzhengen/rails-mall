class Product < ApplicationRecord
  belongs_to :category

  validates_presence_of :category_id, message: '请选择分类'
  validates_presence_of :title, message: '请输入商品标题'
  validates :status, inclusion: { in: %w[on off], message: '请选择商品状态' }
  validates_presence_of :amount, message: '请输入库存数量'
  validates :amount, numericality: { only_integer: true, message: '库存必须为整数' },
            if: proc { |product| !product.amount.blank? }
  validates_presence_of :msrp, message: '请输入商品MSRP'
  validates_presence_of :price, message: '请输入商品价格'
  validates :msrp, numericality: { message: 'MSRP必须为数字' }, if: proc { |product| !product.msrp.blank? }
  validates :price, numericality: { message: '价格必须为数字' }, if: proc { |product| !product.price.blank? }
  validates_presence_of :description, message: '请输入商品描述'

  before_create :set_default_attrs

  private

  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
  end

end
