class HomeController < ApplicationController
  def index; end

  def search
    @search = params[:query]
    if @search.empty?
      redirect_to root_path, alert: 'A busca não pode ser vazia'
    else
      @order = OrderOfService.find_by('order_service_code LIKE ?', "%#{@search}%")
        if @order.nil?
          redirect_to root_path, alert: 'A busca não é válida'
        else
        unless @order.start_service_order.nil?
          carrier_id = @order.start_service_order.carrier_id
          @carrier = Carrier.find(carrier_id)
        end
      end
    end
  end
end
