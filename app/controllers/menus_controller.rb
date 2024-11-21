class MenusController < ApplicationController
  before_action :authenticate_user_owner!, only: [ :new, :create, :edit, :update, :change_status ]
  before_action :set_params_and_check_user_owner, only: [ :edit, :update, :change_status ]
  def index
    if user_owner_signed_in?
      @menus = current_user_owner.menus
    elsif user_employee_signed_in?
      @menus = current_user_employee.user_owner.menus.active
    else
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end

  def new
    @menu = current_user_owner.establishment.menus.build
  end

  def create
    @menu = current_user_owner.establishment.menus.build(save_params)
    if @menu.save
      redirect_to menus_path, notice: "Cardápio cadastrado com sucesso!"
    else
      flash.now[:alert] = "Não foi possível cadastrar o cardápio."
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @menu = Menu.find(params[:id])
    if user_owner_signed_in?
      if @menu.establishment.user_owner != current_user_owner
        return redirect_to root_path, alert: "Você não possui acesso a este menu."
      end
    elsif user_employee_signed_in?
      if @menu.establishment.user_owner != current_user_employee.user_owner
        return redirect_to root_path, alert: "Você não possui acesso a este menu."
      end
    else
      redirect_to pa_leva_session_path, alert: 'Para continuar, faça login ou registre-se.'
    end
  end

  def edit; end

  def update
    if @menu.update(save_params)
      redirect_to @menu, notice: "Cardápio atualizado com sucesso."
    else
      flash.now[:alert] = "Falha ao atualizar cardápio"
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status
    @menu.status = !@menu.status
    if @menu.save
      redirect_to @menu, notice: 'Status do cardápio atualizado com sucesso.'
    else
      redirect_to @menu, alert: 'Não foi possível atualizar o status do cardápio.'
    end
  end

  def add_item_to_order
    session[:order_items] ||= []

    portion = Portion.find(params[:portion_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0
    
    item = { 
    'portion_id' => portion.id, 
    'quantity' => quantity, 
    'note' => params[:note],
    'dish_id' => portion.dish_id, 
    'beverage_id' => portion.beverage_id 
    }

    existing_item = session[:order_items].find { |i| i['portion_id'] == item['portion_id'] }
    if existing_item
      existing_item['quantity'] += item['quantity']
      existing_item['note'] = item['note'] if item['note'].present?
    else
      session[:order_items] << item
    end

    redirect_to menu_path(params[:id]), notice: 'Item adicionado ao pedido.'
  end

  def remove_item_from_order
    if session[:order_items]
      session[:order_items].each_with_index do |item, index|
        if item['portion_id'] == params[:portion_id].to_i
          session[:order_items].delete_at(index)
          break
        end
      end
    end

    redirect_to menu_path(params[:id]), notice: 'Item removido do pedido.'
  end

  private

  def set_params_and_check_user_owner
    @menu = Menu.find(params[:id])
    if @menu.establishment.user_owner != current_user_owner
      return redirect_to root_path, alert: "Você não possui acesso a este cardápio."
    end
  end

  def save_params
    params.require(:menu).permit(:name, dish_ids: [], beverage_ids: [])
  end
end
