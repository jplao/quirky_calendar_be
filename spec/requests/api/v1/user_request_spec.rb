require 'rails_helper'

describe 'as a user' do
  it 'creates an account with api key' do
    params = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users?email=#{params[:email]}&password=#{params[:password]}&password_confirmation=#{params[:password_confirmation]}"

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(user).to have_key(:api_key)
    expect(User.all.count).to eq(1)
  end

  it 'does not create a user if passwords do not match' do
    params = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "notthesame"
    }

    post "/api/v1/users?email=#{params[:email]}&password=#{params[:password]}&password_confirmation=#{params[:password_confirmation]}"

    expect(response.status).to eq(422)
    expect(response.body).to eq("Please try again")
    expect(User.all.count).to eq(0)
  end
end
