class AdditionalFeaturesController < ApplicationController
  before_action :authenticate_user_owner!
  def new
    @dish = Dish.find(params[:dish_id])
    @additional_feature = @dish.additional_features.new
  end

  def create
    @dish = Dish.find(params[:dish_id])
    @additional_feature = @dish.additional_features.build(save_params)
    if @additional_feature.save
      redirect_to @dish, notice: 'Marcador adicionado com sucesso.'
    else
      flash.now[:alert] = "Não foi possível cadastrar o marcador."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def save_params
    params.require(:additional_feature).permit(:name, :active)
  end
end
