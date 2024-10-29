class BeveragesController < ApplicationController
  before_action :authenticate_user_owner!
  before_action :set_params_and_check_user_owner, only: [:show, :edit, :update, :change_status]
  def index
    @beverages = current_user_owner.establishment.beverages
  end

  def new
    @beverage = Beverage.new
  end

  def create
    @beverage = Beverage.new(save_params)
    @beverage.establishment = current_user_owner.establishment

    if @beverage.save
      redirect_to beverages_path, notice: "Bebida cadastrada com sucesso!"
    else
      flash.now[:alert] = "Falha ao cadastrar bebida"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @beverage.update(save_params)
      redirect_to @beverage, notice: "Bebida atualizado com sucesso."
    else
      flash.now[:alert] = "Falha ao cadastrar bebida"
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status
    @beverage.status = !@beverage.status
    if @beverage.save
      redirect_to @beverage, notice: 'Status da bebida atualizado com sucesso.'
    else
      redirect_to @beverage, alert: 'Não foi possível atualizar o status da bebida.'
    end
  end
  
  private

  def set_params_and_check_user_owner
    @beverage = Beverage.find(params[:id])
    if @beverage.establishment.user_owner != current_user_owner
      return redirect_to root_path, notice: "Você não possui acesso a esta bebida."
    end
  end

  def save_params
    params.require(:beverage).permit(:name, :description, :alcoholic, :calories, :photo)
  end
end