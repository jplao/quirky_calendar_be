require 'rails_helper'

describe 'as a visitor' do
  before(:each) do
    Holiday.create({
                    date: "2019-02-25T00:00:00.000Z",
                    name: "Chocolate-Covered Peanuts Day",
                    url:"http://www.daysoftheyear.com/days/chocolate-covered-peanuts-day/"
      })
    Holiday.create({
                    date: "2019-02-25T00:00:00.000Z",
                    name: "Clam Chowder Day",
                    url: "http://www.daysoftheyear.com/days/clam-chowder-day/"
      })
    Holiday.create({
                    date: "2019-02-25T00:00:00.000Z",
                    name: "Pistol Patent Day",
                    url: "http://holidayinsights.com/moreholidays/February/pistolpatentday.htm"
      })
  end

  it 'gets current holidays' do
    get "/api/v1/holidays?date=2019-02-25"

    expect(response).to be_successful

    holidays = JSON.parse(response.body, symbolize_names: true)
    holidays_array = holidays[:data]
    expect(holidays_array.count).to eq(3)
    expect(holidays_array[0][:attributes][:date]).to eq("2019-02-25T00:00:00.000Z")
    expect(holidays_array[0][:attributes][:name]).to eq("Chocolate-Covered Peanuts Day")
    expect(holidays_array[0][:attributes][:url]).to eq("http://www.daysoftheyear.com/days/chocolate-covered-peanuts-day/")
  end
end
