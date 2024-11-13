class EmployeePreRegistrationsController < ApplicationController
  before_action :authenticate_user_owner!

  def index
    @pre_registrations = EmployeePreRegistration.all
  end

  def new
    @pre_registrations = current_user_owner.employee_pre_registrations.build
  end
  
  def create
    @pre_registrations = current_user_owner.employee_pre_registrations.build(save_params)
    @pre_registrations.establishment = current_user_owner.establishment

    if @pre_registrations.save
      redirect_to employee_pre_registrations_path, notice: "Funcionário cadastrado com sucesso!"
    else
      flash.now[:alert] = "Falha ao cadastrar funcionário!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def save_params
    params.require(:employee_pre_registration).permit(:email, :cpf)
  end
end