class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def authorize_request
    client_request = AuthorizeRequest.new(request.headers)

    if client_request.valid?
      @current_user = client_request.user
    else
      render json: { 'message': client_request.errors.full_messages },
             status: :unauthorized
    end
  end
end
