class HomeController < ApplicationController
  def index; end

  def search
    @order = OrderOfService.find_by('order_service_code LIKE ?', "%#{params[:query]}%")
    unless @order.start_service_order.nil?
      carrier_id = @order.start_service_order.carrier_id
      @carrier = Carrier.find(carrier_id)
    end
  end
end
