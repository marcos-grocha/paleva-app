class MenusController < ApplicationController
  before_action :authenticate_user_owner!
  def index
    @menus = current_user_owner.menus
  end

  def new
    @menu = current_user_owner.menus.build
  end

  def create
    @menu = current_user_owner.menus.build(save_params)
    if @menu.save
      redirect_to menus_path, notice: "Cardápio cadastrado com sucesso!"
    else
      render :new, alert: "Não foi possível cadastrar o cardápio."
    end
  end

  def show
    @menu = current_user_owner.menus.find(params[:id])
  end

  private

  def save_params
    params.require(:menu).permit(:name, dish_ids: [], beverage_ids: [])
  end
end
