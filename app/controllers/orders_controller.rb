class OrdersController < ApplicationController
  def index
    @orders = current_user_owner.orders if user_owner_signed_in?
    @orders = current_user_employee.user_owner.orders if user_employee_signed_in?
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
      @order = current_user_owner.orders.build(save_params)
      if @order.save
        session[:order_items].each do |item|
          @order.order_items.create!(
            portion_id: item['portion_id'], 
            quantity: item['quantity'], 
            dish_id: item['dish_id'], 
            beverage_id: item['beverage_id'])
        end

        session.delete(:order_items)
        redirect_to orders_path, notice: 'Pedido realizado com sucesso'
      else
        flash.now[:alert] = 'Falha ao realizar pedido'
        render :new, status: :unprocessable_entity
      end
    elsif user_employee_signed_in?
      @order = current_user_employee.user_owner.orders.build(save_params)
      if @order.save
        session[:order_items].each do |item|
          @order.order_items.create!(
            portion_id: item['portion_id'], 
            quantity: item['quantity'], 
            dish_id: item['dish_id'], 
            beverage_id: item['beverage_id'])
        end

        session.delete(:order_items)
        redirect_to orders_path, notice: 'Pedido realizado com sucesso'
      else
        flash.now[:alert] = 'Falha ao realizar pedido'
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def save_params
    params.require(:order).permit(:customer_name, :contact_phone, :contact_email, :cpf, :status, :order_code)
  end
end
