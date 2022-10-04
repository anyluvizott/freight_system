class CarriersController < ApplicationController

  def index
    @carriers = Carrier.all
  end

  def show
    @carrier = Carrier.find(params[:id])
  end

  def new
    @carrier = Carrier.new
    @transport_models = TransportModel.all
  end

  def create
    @carrier = Carrier.new(carrier_params)
    if @carrier.save
      redirect_to @carrier, notice: 'Veículo cadastrado com sucesso.'
    else
      @transport_models = TransportModel.all
      flash.now[:alert] = 'Veículo não cadastrado.'
      render 'new'
    end
  end

  private

  def carrier_params
    params.require(:carrier).permit(:drivers_name, :nameplate, :vehicle_model, :vehicle_brand, :year_of_manufacture, :maximum_weight, :transport_model_id)
  end

end