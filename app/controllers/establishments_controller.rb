class EstablishmentsController < ApplicationController
  before_action :set_params_and_check_user, only: [:show]
  def new
    @establishment = Establishment.new
  end

  def create
    @establishment = Establishment.new(save_params)
    @establishment.user_owner = current_user_owner

    if @establishment.save()
      redirect_to @establishment, notice: "Estabelecimento cadastrado com sucesso!"
    else
      flash.now[:notice] = "Falha ao cadastrar estabelecimento!"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_params_and_check_user
    @establishment = Establishment.find(params[:id])
    if @establishment.user_owner != current_user_owner
      redirect_to root_path, alert: "Você não possui acesso a este estabelecimento."
    end
  end

  def save_params
    params.require(:establishment).permit(:fantasy_name, :corporate_name, :cnpj, :address, :telephone, :email, :code, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :opening_time, :closing_time)
  end
end
