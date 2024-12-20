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
end