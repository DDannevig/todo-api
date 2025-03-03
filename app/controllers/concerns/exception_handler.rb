module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::UnknownFormat, with: :raise_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def raise_not_found
    render_error(status: :not_found, message: I18n.t('errors.invalid_format'))
  end

  def parameter_missing(exception)
    render_error(status: :bad_request, message: exception.original_message)
  end

  def record_not_found(exception)
    render_error(status: :not_found, message: exception.message)
  end
end
