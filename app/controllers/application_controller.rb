class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_votes

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:edit, keys: [:name])
  end

  private

  def set_votes
    @current_votes = current_user.votes.where("created_at > ?", Date.today.beginning_of_month).count if current_user
  end

end
