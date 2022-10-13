class StartServiceOrdersController < ApplicationController
  def create
    @order_of_service = OrderOfService.find(params[:order_of_service_id])

    start_service_order_params = params.require(:start_service_order).permit(:carrier_id,
                                                                             :delivery_type)

    @start_service_order = StartServiceOrder.new(start_service_order_params)
    @start_service_order.order_of_service = @order_of_service

    if @start_service_order.save
      redirect_to @order_of_service, notice: 'Entrega em Rota'

    else
      redirect_to @order_of_service, notice: 'Entrega não concluída'
    end
  end
end
