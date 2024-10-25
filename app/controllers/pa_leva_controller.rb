class PaLevaController < ApplicationController
  def index
    unless user_owner_signed_in?
      return redirect_to new_user_owner_session_path
    end

    if user_owner_signed_in? && current_user_owner.establishment.nil?
      return redirect_to new_establishment_path
    end

    if user_owner_signed_in? && !current_user_owner.establishment.nil?
      redirect_to establishment_path(current_user_owner.establishment)
    end
  end
end
