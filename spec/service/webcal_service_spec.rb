require 'rails_helper'

describe 'web cal service' do
  before(:each) do
    @service = WebCalService.new()
  end

  it 'exists' do
    expect(@service).to be_an_instance_of(WebCalService)
  end

  context 'it returns an array of upcoming holidays' do
    it '.get_holidays' do
      stub_web_cal_request
        response = @service.get_holidays
        expect(response).to be_an_instance_of(Array)
        expect(response[0][:date]).to eq("2019-01-01")
        expect(response[0][:name]).to eq("Bloody Mary Day")
        expect(response[0][:url]).to eq("http://www.daysoftheyear.com/days/bloody-mary-day/")
    end
  end
end
