class HelpController < ApplicationController
  skip_authorization_check

  def index
  end

  def topic
    render params[:topic]
  end
end
