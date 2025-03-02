class ApplicationController < ActionController::Base
  include ExceptionHandler

  protect_from_forgery with: :null_session

  private

  def render_error(message: nil, status: :bad_request)
    render json: { message: message }, status: status
  end
end
