require 'rails_helper'

describe 'as a user' do
  before(:each) do
    @holiday1 = Holiday.create({
                      date: "2019-02-25T00:00:00.000Z",
                      name: "Chocolate-Covered Peanuts Day",
                      url:"http://www.daysoftheyear.com/days/chocolate-covered-peanuts-day/"
        })
    @holiday2 = Holiday.create({
                      date: "2019-02-25T00:00:00.000Z",
                      name: "Clam Chowder Day",
                      url: "http://www.daysoftheyear.com/days/clam-chowder-day/"
        })
    @user = create(:user)
  end

  context 'creates favorites' do
    it 'saves a holiday to favorites' do
      post "/api/v1/favorites?holiday_id=1&api_key=#{@user.api_key}"

      expect(response).to be_successful
      expect(response.status).to eq (201)
      favorites = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
      expect(favorites).to have_key(:name)
      expect(@user.favorites.count).to eq(1)
    end

    it 'does not save favorite with wrong api key' do
      post "/api/v1/favorites?holiday_id=1&api_key=wrong"

      expect(response.status).to eq(401)
      expect(response.body).to eq("Please try again")
    end

    it 'does not save favorite with no api key' do
      post "/api/v1/favorites?holiday_id=1"

      expect(response.status).to eq(401)
      expect(response.body).to eq("Please try again")
    end
  end

  context 'lists favorites' do
    it 'returns user favorited holidays' do
      Favorite.create(holiday_id: @holiday1.id, user_id: @user.id)
      Favorite.create(holiday_id: @holiday2.id, user_id: @user.id)

      get "/api/v1/favorites?api_key=#{@user.api_key}"

      expect(response).to be_successful
      expect(response.status).to eq (200)

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(favorites.count).to eq(2)
      expect(favorites[0][:attributes][:name]).to eq("Chocolate-Covered Peanuts Day")
    end

    it 'does not list favorites with wrong api key' do
      get "/api/v1/favorites?api_key=wrong"

      expect(response.status).to eq(401)
      expect(response.body).to eq("Please try again")
    end

    it 'does not list favorites with no api key' do
      get "/api/v1/favorites"

      expect(response.status).to eq(401)
      expect(response.body).to eq("Please try again")
    end
  end
end
