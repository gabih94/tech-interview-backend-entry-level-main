class Cart < ApplicationRecord
  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
  end
  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado

  def update_total_price
    self.total_price = cart_items.sum do |item|
      item.quantity * item.product.price
    end
    save!
  end

  def abandoned?
    last_interaction_at.nill? || last_interaction_at < 3.hour.ago
  end

  def abandoned
    update(status: 'abandoned') if abandoned?
  end

  def must_be_deleted
    last_interaction_at < 7.days.ago && status == 'abandoned'
  end
end
