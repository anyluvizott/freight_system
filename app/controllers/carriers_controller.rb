class CarriersController < ApplicationController
  # GET / carriers
  def index
    @carriers = Carrier.all
  end

  # GET / carriers / 1
  def show
    @carrier = Carrier.find(params[:id])
  end

  # GET / carriers / new
  def new
    @carrier = Carrier.new
    @transport_models = TransportModel.all
  end

  # POST / carriers
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

  # GET / carriers / 1 / edit
  def edit
    @carrier = Carrier.find(params[:id])
    @transport_models = TransportModel.all
  end

  def update
    @carrier = Carrier.find(params[:id])
    @transport_models = TransportModel.all

    if @carrier.update(carrier_params)
      redirect_to @carrier, notice: 'Veículo atualizado com sucesso.'

    else
      @transport_models = TransportModel.all
      flash.now[:alert] = 'Não foi possível atualizar'
      render 'edit'
    end
  end

  private

  def carrier_params
    params.require(:carrier).permit(:drivers_name, :nameplate, :vehicle_model, :vehicle_brand, :year_of_manufacture,
                                    :maximum_weight, :transport_model_id)
  end
end
