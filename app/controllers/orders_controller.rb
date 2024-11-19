class OrdersController < ApplicationController
  def index
    if user_owner_signed_in?
      @orders = current_user_owner.establishment.orders
    elsif user_employee_signed_in?
      @orders = current_user_employee.user_owner.establishment.orders
    else
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end

  def new
    if user_owner_signed_in? || user_employee_signed_in?
      @order = Order.new
    else
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end
  
  def create
    if user_owner_signed_in?
      @order = current_user_owner.establishment.orders.build(save_params)
    elsif user_employee_signed_in?
      @order = current_user_employee.user_owner.establishment.orders.build(save_params)
    else
      redirect_to pa_leva_session_path, alert: 'Para continuar, faça login ou registre-se.'
    end
  
    if @order.save
      session[:order_items].each do |item|
        @order.order_items.create!(
          portion_id: item['portion_id'], 
          quantity: item['quantity'],
          note: item['note'],
          dish_id: item['dish_id'], 
          beverage_id: item['beverage_id']
        )
      end
      session.delete(:order_items)
      redirect_to orders_path, notice: 'Pedido realizado com sucesso'
    else
      flash.now[:alert] = 'Falha ao realizar pedido'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
    if user_owner_signed_in?
      if @order.establishment.user_owner != current_user_owner
        return redirect_to root_path, alert: "Você não possui acesso a este pedido."
      end
    elsif user_employee_signed_in?
      if @order.establishment.user_owner != current_user_employee.user_owner
        return redirect_to root_path, alert: "Você não possui acesso a este pedido."
      end
    else
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end

  private

  def save_params
    params.require(:order).permit(:customer_name, :contact_phone, :contact_email, :cpf, :status, :order_code)
  end
end
