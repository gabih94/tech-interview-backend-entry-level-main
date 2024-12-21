class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  after_save :update_cart_interaction_time

  private

  def update_cart_interaction_time
    cart.update(last_interaction_at: Time.current)
  end
end
