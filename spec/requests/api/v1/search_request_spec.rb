require 'rails_helper'

describe 'as a visitor' do
  before(:each) do
    Holiday.create({date: "2019-02-01T00:00:00.000Z",
                    name: "Decorating With Candy Day",
                    url: "http://www.daysoftheyear.com/days/decorating-with-candy-day/"
        })
    Holiday.create({
                    date: "2019-10-30T00:00:00.000Z",
                    name: "Candy Corn Day",
                    url: "http://holidayinsights.com/moreholidays/October/candycornday.htm"
      })
    Holiday.create({
                    date: "2019-12-07T00:00:00.000Z",
                    name: "Cotton Candy Day",
                    url: "http://holidayinsights.com/moreholidays/December/cottoncandyday.htm"})
  end

  it 'gets current holidays' do
    get "/api/v1/search?name=Candy"

    expect(response).to be_successful

    holidays = JSON.parse(response.body, symbolize_names: true)
    expect(holidays[:data].count).to eq(3)
    first_holiday = holidays[:data][0][:attributes]
    expect(first_holiday[:date]).to eq("2019-02-01T00:00:00.000Z")
    expect(first_holiday[:name]).to eq("Decorating With Candy Day")
    expect(first_holiday[:url]).to eq("http://www.daysoftheyear.com/days/decorating-with-candy-day/")
  end
end
