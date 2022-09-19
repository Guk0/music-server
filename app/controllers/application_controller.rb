class ApplicationController < ActionController::API
  include Pundit::Authorization

  Forbidden = Class.new(StandardError)

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid_record
  rescue_from ApplicationController::Forbidden, with: :rescue_forbidden
  rescue_from Pundit::NotAuthorizedError, with: :rescue_forbidden 

  def current_user
    User.find(request.headers["Authorization"])
  rescue
    raise ApplicationController::Forbidden
  end

  protected
  def rescue_forbidden(e)
    render json: { message: "You don't have permission to do this." }, status: 403
  end

  def rescue_invalid_record(e)
    render json: { message: e.record.errors.full_messages }, status: 422
  end
  
  def authenticate_user object, user, &block
    # 추후 auth 기능이 추가된 뒤 user를 current_user로 변경한다.
    condition = block_given? ? yield : object.check_user(user)
    unless condition
      raise ApplicationController::Forbidden
    end
  end
end
