class Product < ApplicationRecord
  belongs_to :category

  validates_presence_of :title
  validates_presence_of :status
  validates_presence_of :amount
  validates_presence_of :msrp
  validates_presence_of :price

  before_create :set_default_attrs

  private

  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
  end

end
