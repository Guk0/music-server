class ApplicationController < ActionController::API
  def do_or_render_403 condition, &block
    if condition
      yield
    else
      render json: { error: "You don't have permission to do this." }, status: 403
    end
  end
end
