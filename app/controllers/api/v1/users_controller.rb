class Api::V1::UsersController < ApplicationController
  def create
    if valid_password?
      @user = User.create(user_params)
      render json: UserSerializer.new(@user), status: 201
    else
      render json: "Please try again", status: 422
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

    def valid_password?
      params[:password] == params[:password_confirmation]
    end
end
