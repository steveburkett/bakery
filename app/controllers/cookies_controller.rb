class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.empty?
      @cookie = @oven.cookies.build
    else
      redirect_to @oven, alert: 'A cookie or more is already in the oven!'
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    how_many = params[:cookie][:how_many].to_i

    @oven.bake_some_cookies(how_many, cookie_params)

    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
