class DeliveryTimesController < ApplicationController
  def index
    @delivery_times = DeliveryTime.all
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)

    if @delivery_time.save
      redirect_to delivery_times_path, notice: 'Novo valor adicionado'
    else
      flash.now[:alert] = 'Não foi possível adicionar novo valor'
      render 'index'
    end
  end

  def update; end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(:starting_km, :final_km, :deadline)
  end
end
