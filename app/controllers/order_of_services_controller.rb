class OrderOfServicesController < ApplicationController
  before_action :authenticate_user!
  def index
    @order_of_services = OrderOfService.all.order(status: :asc)
  end

  def show
    @order_of_service = OrderOfService.find(params[:id])
    @start_service_order = StartServiceOrder.new
    @transport_models = TransportModel.all
    @carriers = select_carriers
    @sum = sum
    @select_transport_model = select_transport_model
    @deadline = deadline
    @timelimit = timelimit unless @order_of_service.final_date.nil?
    @carrier_start_service_order = carrier_start_service_order unless @order_of_service.start_service_order.nil?

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

    if @order_of_service.update(order_of_service_params)
      redirect_to @order_of_service, notice: 'Ordem de Serviço Atualizada'
    else
      flash.now[:alert] = 'Não foi possível atualizar Ordem de Serviço'
      render 'edit'
    end
  end

  def on_route
    @order_of_service = OrderOfService.find(params[:id])
    @order_of_service.on_route!
    redirect_to @order_of_service, notice: 'Ordem de Serviço em Rota'
  end

  def delivered
    @order_of_service = OrderOfService.find(params[:id])
    @order_of_service.final_date = Time.current
    @order_of_service.delivered!
    @carrier = Carrier.find(@order_of_service.start_service_order.carrier_id)
    @carrier.active!

    redirect_to @order_of_service, notice: 'Ordem de Serviço Concluída'
  end

  def search
    @query = params[:query]
    @order_of_service = OrderOfService.where(
      'full_sender_address LIKE ? OR recipient_full_address LIKE ? OR recipients_name LIKE ? OR order_service_code LIKE ? OR product_code LIKE ? OR status LIKE ?', "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%"
    )
  end

  private

  def order_of_service_params
    params.require(:order_of_service).permit(:full_sender_address, :product_height, :product_width,
                                             :product_length, :recipient_full_address, :recipients_name,
                                             :distance, :product_weight, :note)
  end

  def carrier_start_service_order
    carrier = StartServiceOrder.find_by(order_of_service_id: @order_of_service.id).carrier_id
    carrier_found = Carrier.find(carrier)
  end

  def select_carriers
    select_carriers = []
    result = []
    carriers = Carrier.where('maximum_weight >= ?', @order_of_service.product_weight)

    carriers.each do |var|
      if var.transport_model.minimum_weight <= @order_of_service.product_weight.to_i && var.transport_model.minimum_distance <= @order_of_service.distance && var.transport_model.maximum_distance >= @order_of_service.distance
        result << var
      end
    end
    result.each do |var|
      select_carriers << var if var.active?
    end
    select_carriers
  end

  def select_transport_model
    transport = []
    transport_name = []
    select_carriers.each do |tm|
      unless transport_name.include?(tm.transport_model.name)
        transport_name << tm.transport_model.name
        transport << tm
      end
    end
    transport
  end

  def price_by_weights
    value = 0
    price_by_weights = PriceByWeight.where('starting_weight <= ?', @order_of_service.product_weight.to_i)

    price_by_weights.each do |weight|
      value = weight.price_per_km if weight.final_weight >= @order_of_service.product_weight.to_i
    end
    value * @order_of_service.distance
  end

  def price_per_distances
    value = 0
    price_per_distances = PricePerDistance.where('starting_km <= ?', @order_of_service.distance)

    price_per_distances.each do |dist|
      value = dist.fixed_price if dist.final_km >= @order_of_service.distance
    end
    value
  end

  def sum
    price_by_weights + price_per_distances
  end

  def deadline
    deadline = 0
    delivery_time = DeliveryTime.where('starting_km <= ?', @order_of_service.distance)

    delivery_time.each do |dl|
      deadline = dl.deadline if dl.final_km >= @order_of_service.distance
    end
    deadline
  end

  def timelimit
    @order_of_service = OrderOfService.find(params[:id])
    timelimit = ((@order_of_service.final_date-@order_of_service.delivery_date)/1.hour).to_i
  end
end
