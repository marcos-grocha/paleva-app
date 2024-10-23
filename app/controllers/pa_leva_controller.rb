class PaLevaController < ApplicationController
  def index
    if restaurant_owner_signed_in?
      'está logado! redirecione pra la'
    else
      redirect_to new_restaurant_owner_session_path
    end
  end
end
