class Cart < ApplicationRecord
  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
  end

  def update_total_price
    self.total_price = cart_items.sum do |item|
      item.quantity * item.product.price
    end
    save!
  end

  def mark_as_abandoned
    update(status: 'abandoned') if abandoned?
  end

  def abandoned?
    last_interaction_at.nil? || last_interaction_at < 3.hours.ago
  end

  def remove_if_abandoned
    destroy if last_interaction_at < 7.days.ago && status == 'abandoned'
  end
end
