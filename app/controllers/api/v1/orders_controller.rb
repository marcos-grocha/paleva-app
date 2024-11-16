class Api::V1::OrdersController < Api::V1::ApiController
  def index
    establishment_code = params[:establishment_code]
    establishment = Establishment.find_by!(code: establishment_code)
    orders = establishment.user_owner.orders

    if params[:status].present? && Order.statuses.keys.include?(params[:status])
      orders = orders.where(status: params[:status])
    end

    render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
  end
  
end
