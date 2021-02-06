module ExceptionsHandler
  extend ActiveSupport::Concern

  class InvalidParams < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :code_404
    rescue_from ActiveRecord::RecordInvalid, with: :code_400
    rescue_from Pundit::NotAuthorizedError, with: :code_403
    rescue_from ExceptionsHandler::InvalidParams, with: :code_400
  end

  private

  def code_400(err)
    render json: { message: err.message }, status: 400
  end

  def code_403(_err)
    head 403
  end

  def code_404(err)
    render json: { message: err.message }, status: 404
  end

  def code_422(err)
    render json: { message: err.message }, status: 422
  end 
end