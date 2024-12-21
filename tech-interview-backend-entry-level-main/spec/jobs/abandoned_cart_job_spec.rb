require 'rails_helper'

RSpec.describe AbandonedCartJob, type: :job do
  let!(:active_cart) { create(:cart, last_interaction_at: 4.hours.ago, status: 'active') }
  let!(:abandoned_cart) { create(:cart, last_interaction_at: 8.days.ago, status: 'abandoned') }
  let!(:recent_cart) { create(:cart, last_interaction_at: 1.hour.ago, status: 'active') }

  describe '#perform' do
    context 'when performing the job' do
      it 'marks the cart as abandoned if inactive for more than 3 hours' do
        described_class.perform_now
        expect(active_cart.reload.status).to eq('abandoned')
      end

      it 'does not mark the recently active cart as abandoned' do
        described_class.perform_now
        expect(recent_cart.reload.status).to eq('active')
      end

      it 'removes the abandoned cart if inactive for more than 7 days' do
        described_class.perform_now
        expect(Cart.count).to eq(2) 
      end
    end
  end
end
