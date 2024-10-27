class PaLevaController < ApplicationController
  before_action :authenticate_user_owner!
  def index
    redirect_to new_establishment_path if current_user_owner.establishment.nil?

    redirect_to establishment_path(current_user_owner.establishment) unless current_user_owner.establishment.nil?
  end
end
