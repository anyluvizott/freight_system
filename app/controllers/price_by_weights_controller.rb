class PriceByWeightsController < ApplicationController

  def index
    @price_by_weights = PriceByWeight.all
    @price_by_weight = PriceByWeight.new
  end

  def create
    @price_by_weight = PriceByWeight.new(price_by_weights_params)

    if @price_by_weight.save
      redirect_to price_by_weights_path, notice: 'Novo valor adicionado'
    else
      flash.now[:alert] = 'Não foi possível adicionar novo valor'
      render 'index'
    end
  end

  def update; end

  private

  def price_by_weights_params
    params.require(:price_by_weight).permit(:starting_weight, :final_weight, :price_per_km)
  end
  
end
