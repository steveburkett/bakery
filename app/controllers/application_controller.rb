class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :basic_authenticate

  private def basic_authenticate
    return if Rails.env.test?

    authenticate_or_request_with_http_basic do |username, password|
      username == 'bake' && password == 'somecookies'
    end
  end
end
