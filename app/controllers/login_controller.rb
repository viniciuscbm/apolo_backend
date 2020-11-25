class LoginController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    auth = AuthenticateUser.new(login_params)

    return render json: auth.payload if auth.valid?

    render json: { 'message': auth.errors.full_messages }, status: :unauthorized
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
