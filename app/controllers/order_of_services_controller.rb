class OrderOfServicesController < ApplicationController
  def index
    @order_of_services = OrderOfService.all
  end

  def show
    @order_of_service = OrderOfService.find(params[:id])
  end

  def new
    @order_of_service = OrderOfService.new
  end

  def create
    @order_of_service = OrderOfService.new(order_of_service_params)

    if @order_of_service.save
      redirect_to @order_of_service, notice: 'Ordem de Serviço Cadastrada'
    else
      flash.now[:alert] = 'Não foi possível cadastrar Ordem de Serviço'
      render 'new'
    end
  end

  def edit
    @order_of_service = OrderOfService.find(params[:id])
  end

  def update
    @order_of_service = OrderOfService.find(params[:id])

    if order_of_service.update(order_of_service_params)
      redirect_to @order_of_service, notice: 'Ordem de Serviço Atualizada'
    else
      flash.now[:alert] = 'Não foi possível atualizar Ordem de Serviço'
      render 'edit'
    end
  end

  private

  def order_of_service_params
    params.require(:order_of_service).permit(:full_sender_address, :product_height, :product_width,
                                             :product_length, :recipient_full_address, :recipients_name,
                                             :distance, :product_weight)
  end
end
