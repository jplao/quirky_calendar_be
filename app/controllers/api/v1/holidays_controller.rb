class Api::V1::HolidaysController < ApplicationController

  def show
    @holidays = Holiday.where(date: params[:date])
    render json: HolidaySerializer.new(@holidays)
  end

end
