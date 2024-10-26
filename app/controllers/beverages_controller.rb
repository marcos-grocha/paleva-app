class BeveragesController < ApplicationController
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
      flash.now[:notice] = "Falha ao cadastrar bebida"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @beverage = Beverage.find(params[:id])
  end

  def edit; end
  
  private

  def save_params
    params.require(:beverage).permit(:name, :description, :alcoholic, :calories, :photo)
  end
end