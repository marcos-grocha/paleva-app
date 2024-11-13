class EstablishmentsController < ApplicationController
  before_action :authenticate_user_owner!, only: [:new, :create, :search]
  def new
    @establishment = Establishment.new
  end

  def create
    @establishment = Establishment.new(save_params)
    @establishment.user_owner = current_user_owner

    if @establishment.save()
      redirect_to @establishment, notice: "Estabelecimento cadastrado com sucesso!"
    else
      flash.now[:alert] = "Falha ao cadastrar estabelecimento!"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if user_owner_signed_in?
      @establishment = Establishment.find(params[:id])
      if @establishment.user_owner != current_user_owner
        redirect_to root_path, alert: "Você não possui acesso a este estabelecimento."
      end
    elsif user_employee_signed_in?
      @establishment = Establishment.find(params[:id])
      if @establishment.user_owner != current_user_employee.user_owner
        redirect_to root_path, alert: "Você não possui acesso a este estabelecimento."
      end
    else
      redirect_to pa_leva_session_path, alert: 'Para continuar, faça login ou registre-se.'
    end
  end

  def search
    @establishment = current_user_owner.establishment
    query = "%#{params[:query]}%"
    
    if @establishment
      @dishes = @establishment.dishes.where('name LIKE ? OR description LIKE ?', query, query)
      @beverages = @establishment.beverages.where('name LIKE ? OR description LIKE ?', query, query)
      @results = @dishes + @beverages
    else
      @results = []
    end
  end

  private

  def save_params
    params.require(:establishment).permit(:fantasy_name, :corporate_name, :cnpj, :address, :telephone, :email, :code, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :opening_time, :closing_time)
  end
end
