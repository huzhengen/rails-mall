class Category < ApplicationRecord
  has_ancestry
  has_many :products, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :weight

end
