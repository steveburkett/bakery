class Oven < ActiveRecord::Base
  STATUS_COOKING = 'Cooking'.freeze
  STATUS_DONE = 'Done'.freeze

  belongs_to :user
  has_many :cookies, as: :storage, dependent: :destroy

  validates :user, presence: true
  validates_inclusion_of :status, :in => [STATUS_COOKING, STATUS_DONE], allow_nil: true

  def finished_cooking?
    reload.status == STATUS_DONE
  end

  # TODO: If i had more time, i would abstract this out into a Cooking class.  This would
  # also allow the Sidekiq job to be better abstracted for testing simulation and mocking
  # Having this here for now seems fine, but this pattern can quickly lead to model bloat and non-SRP
  def bake_some_cookies(count, cookie_params)
    count.times { cookies.create!(cookie_params) }

    CookingJob.perform_async(id)
  end
end
