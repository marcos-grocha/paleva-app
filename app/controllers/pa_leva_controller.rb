class PaLevaController < ApplicationController
  def start
    redirect_to pa_leva_session_path unless user_owner_signed_in? || user_employee_signed_in?

    redirect_to new_establishment_path if user_owner_signed_in? && current_user_owner.establishment.nil?
      
    redirect_to menus_path if user_owner_signed_in? && !current_user_owner.establishment.nil?

    redirect_to menus_path if user_employee_signed_in?
  end

  def details; end

  def session; end

end
