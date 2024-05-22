class ApplicationController < ActionController::API
  def not_found_method
    render json: { status: 404, message: "Path #{params[:unmatched]} not found!" }, status: :not_found
  end

  def render_ok(message)
    render json: { status: 200, message: }, status: :ok
  end

  def render_internal_server_error(message)
    render json: { status: 500, message: }, status: :internal_server_error
  end
end
