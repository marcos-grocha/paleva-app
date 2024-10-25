class PaLevaController < ApplicationController
  def index
    if user_owner_signed_in?
      if current_user_owner.establishment.nil?
        redirect_to new_establishment_path
      end
    else
      redirect_to new_user_owner_session_path
    end
  end
end
