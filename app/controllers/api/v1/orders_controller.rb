class Api::V1::OrdersController < Api::V1::ApiController
  def index
    orders = Order.all
    render status: 200, json: orders    
  end
end