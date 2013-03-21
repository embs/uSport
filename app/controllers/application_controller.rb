class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  # \/ deixa o cara na mesma página após logar ou deslogar
  def after_sign_out_path_for(resource_or_scope)
  request.referrer
  end
  def after_sign_in_path_for(resource_or_scope)
  request.referrer
  end
end
