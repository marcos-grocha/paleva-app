class AdditionalFeaturesController < ApplicationController
  def new
    @dish = Dish.find(params[:dish_id])
    @additional_feature = @dish.additional_features.new
  end

  def create
    @dish = Dish.find(params[:dish_id])
    @additional_feature = @dish.additional_features.build(save_params)
    if @additional_feature.save
      redirect_to @dish, notice: 'Característica adicionada com sucesso.'
    else
      render :new, alert: 'Não foi possível cadastrar a característica.'
    end
  end

  private

  def save_params
    params.require(:portion).permit(:name, :active)
  end
end