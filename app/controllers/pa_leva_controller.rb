class PaLevaController < ApplicationController
  def index
    if user_signed_in?
      'está logado! redirecione pra la'
    else
      redirect_to new_user_session_path
    end
  end
end
