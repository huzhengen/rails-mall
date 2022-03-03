class ShoppingCart < ApplicationRecord
  belongs_to :product
  # belongs_to :user

  validates_presence_of :user_uuid
  validates_presence_of :product_id
  validates_presence_of :amount

  scope :by_user_uuid, ->(user_uuid) { where(user_uuid: user_uuid) }
  # scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

  def self.create_or_update! options = {}
    cond = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
    }
    record = where(cond).first
    if record
      record.update_attributes!(options.merge(amount: cart.amount + options.amount))
    else
      record = create!(options)
    end
    record
  end
end
