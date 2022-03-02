class Category < ApplicationRecord

  validates_presence_of :title, message: '请输入分类名称'
  validates :title, uniqueness: { message: '分类名称不能重复' }
  validates_presence_of :weight, message: '请输入分类权重'

  has_ancestry orphan_strategy: :destroy
  has_many :products, dependent: :destroy

  before_validation :correct_ancestry

  def self.grouped_data
    self.roots.order('weight desc').inject([]) do |results, parent|
      row = []
      row << parent
      row << parent.children.order('weight desc')
      results << row
    end
  end

  private

  def correct_ancestry
    # self.ancestry == '' ? nil : self.ancestry
    self.ancestry = nil if self.ancestry.blank?
  end

end
