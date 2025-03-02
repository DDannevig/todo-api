module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::UnknownFormat, with: :raise_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
  end

  private

  def raise_not_found
    render_error(status: :not_found, message: I18n.t('errors.invalid_format'))
  end

  def parameter_missing(exception)
    render_error(status: :bad_request, message: exception.original_message)
  end
end
