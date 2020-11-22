class HealthCheckController < ApplicationController
  def index
    render json: { environment: Rails.env }, status: :ok
  end
end
