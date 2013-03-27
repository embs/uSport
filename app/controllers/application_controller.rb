# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if current_user # usuário está logado mas mesmo assim não tem acesso
      redirect_to root_url, alert: exception.message
    else # usuário não está logado
      session[:return_to] ||= request.fullpath
      redirect_to new_user_session_path, alert: "Você precisa estar logado."
    end
  end

  # Deixa o cara na mesma página após deslogar
  def after_sign_out_path_for(resource_or_scope)
    request.env['omniauth.origin'] || request.referer || root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    request.env['omniauth.origin'] || session.delete(:return_to) || root_path
  end
end
