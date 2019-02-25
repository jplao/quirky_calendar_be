class Api::V1::FavoritesController < ApplicationController
  def create
    if find_by_api
      @user = find_by_api
      @user.favorites.create(holiday_id: params[:holiday_id])
      holiday = Holiday.find(@user.favorites.last.holiday_id)
      render json: HolidaySerializer.new(holiday), status: 201
    else
      render json: 'Please try again', status: 401
    end
  end

  def show
    if find_by_api
      @user = find_by_api
      favorite_holidays = @user.find_favorites
      render json: HolidaySerializer.new(favorite_holidays)
    else
      render json: 'Please try again', status: 401
    end
  end

  private
  def find_by_api
    User.find_by(api_key: params[:api_key])
  end
end
