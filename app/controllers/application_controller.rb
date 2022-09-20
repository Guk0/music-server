class ApplicationController < ActionController::API
  include Pundit::Authorization

  Forbidden = Class.new(StandardError)
  Unauthorized = Class.new(StandardError)

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid_record
  rescue_from ApplicationController::Unauthorized, with: :rescue_unauthorized 
  rescue_from Pundit::NotAuthorizedError, with: :rescue_forbidden   


  def current_user
    User.find(request.headers["Authorization"])
  rescue
    raise ApplicationController::Unauthorized
  end

  protected
  def rescue_forbidden(e)
    render json: { message: "You don't have permission to do this." }, status: 403
  end

  def rescue_unauthorized(e)
    render json: { message: "Unauthorized" }, status: 401
  end

  def rescue_invalid_record(e)
    render json: { message: e.record.errors.full_messages }, status: 422
  end  
end
