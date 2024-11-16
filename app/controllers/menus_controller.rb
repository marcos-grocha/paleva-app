class MenusController < ApplicationController
  before_action :authenticate_user_owner!, only: [ :new, :create, :edit ]
  def index
    @menus = current_user_owner.menus if user_owner_signed_in?
    @menus = current_user_employee.user_owner.menus if user_employee_signed_in?
  end

  def new
    @menu = current_user_owner.menus.build
  end

  def create
    @menu = current_user_owner.menus.build(save_params)
    if @menu.save
      redirect_to menus_path, notice: "Cardápio cadastrado com sucesso!"
    else
      flash.now[:alert] = "Não foi possível cadastrar o cardápio."
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    if user_owner_signed_in?
      @menu = current_user_owner.menus.find(params[:id])
      if @menu.user_owner != current_user_owner
        return redirect_to root_path, alert: "Você não possui acesso a este menu."
      end
    elsif user_employee_signed_in?
      @menu = current_user_employee.user_owner.menus.find(params[:id])
      if @menu.user_owner != current_user_employee.user_owner
        return redirect_to root_path, alert: "Você não possui acesso a este menu."
      end
    else
      redirect_to pa_leva_session_path, alert: 'Para continuar, faça login ou registre-se.'
    end
  end

  def edit; end

  def add_item_to_order
    session[:order_items] ||= []

    portion = Portion.find(params[:portion_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0
    
    item = { 
      portion_id: portion.id, 
      quantity: params[:quantity].to_i, 
      note: params[:note],
      dish_id: portion.dish_id, 
      beverage_id: portion.beverage_id 
    }

    existing_item = session[:order_items].find { |i| i['portion_id'] == item[:portion_id] }
    if existing_item
      existing_item['quantity'] += item[:quantity]
      existing_item['note'] = item[:note] if item[:note].present?
    else
      session[:order_items] << item
    end

    redirect_to menu_path(params[:id]), notice: 'Item adicionado ao pedido.'
  end

  def remove_item_from_order
    if session[:order_items]
      session[:order_items].each_with_index do |item, index|
        if item[:portion_id] == params[:portion_id]
          session[:order_items].delete_at(index)
          break
        end
      end
    end

    redirect_to menu_path(params[:id]), notice: 'Item removido do pedido.'
  end

  private

  def save_params
    params.require(:menu).permit(:name, dish_ids: [], beverage_ids: [])
  end
end
