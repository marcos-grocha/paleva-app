class DishesController < ApplicationController
  before_action :authenticate_user_owner!
  before_action :set_params_and_check_user_owner, only: [:show, :edit, :update]
  def index
    @dishes = current_user_owner.establishment.dishes
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(save_params)
    @dish.establishment = current_user_owner.establishment

    if @dish.save
      redirect_to dishes_path, notice: "Prato cadastrado com sucesso!"
    else
      flash.now[:alert] = "Falha ao cadastrar prato"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @dish.update(save_params)
      redirect_to @dish, notice: "Prato atualizado com sucesso."
    else
      flash.now[:alert] = "Falha ao atualizar prato"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_params_and_check_user_owner
    @dish = Dish.find(params[:id])
    if @dish.establishment.user_owner != current_user_owner
      return redirect_to root_path, alert: "Você não possui acesso a este prato."
    end
  end
  
  def save_params
    params.require(:dish).permit(:name, :description, :calories, :photo)
  end
end