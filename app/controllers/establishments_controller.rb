class EstablishmentsController < ApplicationController
  before_action :authenticate_user_owner!, only: [:new, :create, :edit, :update, :search]
  before_action :set_params_and_check_user_owner, only: [:edit, :update]
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

  def edit; end
  
  def update
    if @establishment.update(save_params)
      redirect_to @establishment, notice: "Estabelecimento atualizado com sucesso."
    else
      flash.now[:alert] = "Falha ao atualizar estabelecimento!"
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @establishment = Establishment.find(params[:id])
    if user_owner_signed_in?
      if @establishment.user_owner != current_user_owner
        redirect_to root_path, alert: "Você não possui acesso a este estabelecimento."
      end
    elsif user_employee_signed_in?
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

  def set_params_and_check_user_owner
    @establishment = Establishment.find(params[:id])
    if @establishment.user_owner != current_user_owner
      return redirect_to root_path, alert: "Você não possui acesso a este estabelecimento."
    end
  end

  def save_params
    params.require(:establishment).permit(:fantasy_name, :corporate_name, :cnpj, :address, :telephone, :email, :code, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :opening_time, :closing_time)
  end
end
