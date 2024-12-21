class AbandonedCartJob < ApplicationJob
  queue_as :default

  def perform
    Cart.where('last_interaction_at < ?', 3.hours.ago).find_each do |cart|
      cart.mark_as_abandoned
    end

    Cart.where('last_interaction_at < ?', 7.days.ago).where(status: 'abandoned').find_each do |cart|
      cart.remove_if_abandoned
    end
  end
end
