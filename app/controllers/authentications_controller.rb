# encoding: utf-8
class AuthenticationsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    # Procura autenticação buscando pelo provider e uid
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      # Autenticação existente -> apenas loga o usuário
      flash[:notice] = "Logado com sucesso"
      sign_in_and_redirect(:user, authentication.user)
    else
      # Autenticação inexistente -> cria usuário e loga
      user = User.create_with_omniauth(auth)
      if user
        Authentication.create(:provider => auth['provider'], :user_id => user.id,
                              :uid => auth[:uid])
        flash[:notice] = "Conta criada a partir da conta do Facebook"
        sign_in_and_redirect(:user, user)
      else
        flash[:error] = "Não foi possível logar com o Facebook"
        redirect_to root_path
      end
    end
  end
end
