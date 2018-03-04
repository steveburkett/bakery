class CookingChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.debug("CookingChannel subscribed")
    stream_from "cooking_channel"
  end

  def unsubscribed
    Rails.logger.debug("CookingChannel unsubscribed")
  end
end
