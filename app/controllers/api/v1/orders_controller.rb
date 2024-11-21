class Api::V1::OrdersController < Api::V1::ApiController
  before_action :set_establishment
  before_action :set_order, only: [:show, :update, :cancel]

  def index
    orders = @establishment.orders

    if params[:status].present? && Order.statuses.keys.include?(params[:status])
      orders = orders.where(status: params[:status])
    end

    render status: 200, json: orders.as_json(except: [:updated_at])
  end

  def show 
    order_details = @order.as_json(
      only: [:order_code, :customer_name, :status, :created_at],
      methods: [:order_items_details]
    )

    render status: 200, json: order_details
  end

  def update
    if @order.waiting_confirmation?
      @order.update(status: :in_preparation, in_preparation_date: DateTime.now)
    elsif @order.in_preparation?
      @order.update(status: :ready, ready_date: DateTime.now)
    end

    order_details = @order.as_json(
      only: [:id, :customer_name, :contact_phone, :contact_email, 
              :cpf, :status, :order_code, :created_at, 
              :in_preparation_date, :ready_date],
      methods: [:order_items_details]
    )

    render status: 200, json: order_details
  end

  def cancel
    reason = params[:reason]
    if reason.blank?
      render status: 400, json: { error: "O motivo do cancelamento é obrigatório." }
      return
    end

    @order.update(status: :cancelled, cancellation_reason: reason)

    order_details = @order.as_json(
      only: [:id, :customer_name, :contact_phone, :contact_email, 
              :cpf, :status, :order_code, :created_at, 
              :in_preparation_date, :ready_date, :cancellation_reason],
      methods: [:order_items_details]
    )

    render status: 200, json: order_details
  end
  
  private

  def set_establishment
    @establishment = Establishment.find_by!(code: params[:establishment_code])
  rescue ActiveRecord::RecordNotFound
    render status: 404, json: { error: 'Estabelecimento não encontrado' }
  end

  def set_order
    @order = @establishment.orders.find_by!(order_code: params[:order_code])
  rescue ActiveRecord::RecordNotFound
    render status: 404, json: { error: 'Pedido não encontrado' }
  end

end
