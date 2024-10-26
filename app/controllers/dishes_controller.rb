class DishesController < ApplicationController
  # before_action :authenticate_user_owner!
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
      flash.now[:notice] = "Falha ao cadastrar prato"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end

  def edit; end

  private
  
  def save_params
    params.require(:dish).permit(:name, :description, :calories, :photo)
  end
end