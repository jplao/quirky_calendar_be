class Api::V1::SearchController < ApplicationController
  def show
    @holidays = Holiday.where("name like ?", "%#{params[:name]}%")
    render json: HolidaySerializer.new(@holidays)
  end
end
