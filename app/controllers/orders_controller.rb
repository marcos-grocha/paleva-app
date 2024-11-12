class OrdersController < ApplicationController
  before_action :authenticate_user_owner!
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end
  
  def create
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
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def save_params
    params.require(:order).permit(:customer_name, :contact_phone, :contact_email, :cpf, :status, :order_code)
  end
end
