require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { create(:cart, last_interaction_at: 1.hour.ago) }
  let(:product) { create(:product) }

  describe 'callbacks' do
    it 'updates the last_interaction_at of the associated cart after save' do
      cart_item = create(:cart_item, cart: cart, product: product)

      # Verifica se o `last_interaction_at` foi atualizado para o horário atual
      expect(cart.last_interaction_at).to be_within(1.second).of(Time.current)
    end
  end
end
