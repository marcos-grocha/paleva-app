class PortionsController < ApplicationController
  before_action :authenticate_user_owner!
  before_action :set_dish_or_beverage
  before_action :set_portion, only: [ :show, :edit, :update ]

  def new
    @portion = @parent.portions.new
  end

  def create
    @portion = @parent.portions.build(save_params)
    if @portion.save
      redirect_to @parent, notice: 'Porção cadastrada com sucesso.'
    else
      flash.now[:alert] = "Não foi possível cadastrar a porção."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @price_histories = @portion.price_histories
  end

  def edit; end

  def update
    if @portion.update(save_params)
      redirect_to @parent, notice: 'Porção atualizada com sucesso.'
    else
      flash.now[:alert] = "Não foi possível editar a porção."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_dish_or_beverage
    if params[:dish_id]
      @parent = Dish.find(params[:dish_id])
    elsif params[:beverage_id]
      @parent = Beverage.find(params[:beverage_id])
    else
      redirect_to root_path, alert: "ID do Prato ou da Bebida não encontrado."
    end
  end

  def set_portion
    @portion = Portion.find(params[:id])
  end

  def save_params
    params.require(:portion).permit(:description, :price)
  end
end
