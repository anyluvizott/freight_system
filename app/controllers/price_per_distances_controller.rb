class PricePerDistancesController < ApplicationController

  def index
    @price_per_distances = PricePerDistance.all
    @price_per_distance = PricePerDistance.new
  end

  def create
    @price_per_distance = PricePerDistance.new(price_per_distances_params)

    if @price_per_distance.save
      redirect_to price_per_distances_path, notice: 'Novo valor adicionado'
    else
      flash.now[:alert] = 'Não foi possível adicionar novo valor'
      render 'index'
    end
  end

  def update; end

  private

  def price_per_distances_params
    params.require(:price_per_distance).permit(:starting_km, :final_km, :fixed_price)
  end  
end