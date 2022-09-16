class ApplicationController < ActionController::API
  Forbidden = Class.new(StandardError)

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid_record
  rescue_from ApplicationController::Forbidden, with: :rescue_forbidden


  protected
  def rescue_forbidden(e)
    render json: { message: "You don't have permission to do this." }, status: 403
  end

  def rescue_invalid_record(e)
    render json: { message: e.record.errors.full_messages }, status: 422
  end
end
