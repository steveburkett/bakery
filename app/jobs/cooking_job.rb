class CookingJob
  include ::Sidekiq::Worker

  def perform(oven_id)
    # Simulate cooking in an oven (see comment below).
    # It takes 10 seconds to cook a batch (of 1 or more) cookies
    Oven.find_by(id: oven_id).update!(status: Oven::STATUS_COOKING)
    cook
    Oven.find_by(id: oven_id).update!(status: Oven::STATUS_DONE)
    ActionCable.server.broadcast 'cooking_channel', message: { oven: { id: oven_id } }
  end

  # TODO abstract into a cooking class, to better separate the concerns of the responsibilities of
  # job infrastructure and cooking
  def cook
    sleep(5)
  end
end
