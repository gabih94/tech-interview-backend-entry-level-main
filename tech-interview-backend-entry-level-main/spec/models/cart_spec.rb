require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'when validating' do
    it 'validates numericality of total_price' do
      cart = described_class.new(total_price: -1)
      expect(cart.valid?).to be_falsey
      expect(cart.errors[:total_price]).to include("must be greater than or equal to 0")
    end
  end

  describe 'mark_as_abandoned' do
    let(:shopping_cart) { create(:cart, last_interaction_at: Time.current) }  # Usa o modelo `cart`

    it 'marks the shopping cart as abandoned if inactive for a certain time' do
      expect(shopping_cart.abandoned?).to eq(false)
      shopping_cart.update(last_interaction_at: 4.hours.ago)
      expect {
        shopping_cart.mark_as_abandoned
        shopping_cart.reload
      }.to change { shopping_cart.status }.from('active').to('abandoned')
    end
  end

  describe 'remove_if_abandoned' do
    let(:shopping_cart) { create(:cart, last_interaction_at: 7.days.ago) }  # Usa o modelo `cart`

    it 'removes the shopping cart if abandoned for a certain time' do
      shopping_cart.mark_as_abandoned
      expect { shopping_cart.remove_if_abandoned }.to change { Cart.count }.by(-1)
    end
  end
end
