class PriceByWeightsController < ApplicationController
  before_action :authenticate_user!

  def index
    @price_by_weights = PriceByWeight.all
    @price_by_weight = PriceByWeight.new
  end

  def create
    @price_by_weight = PriceByWeight.new(price_by_weights_params)

    if @price_by_weight.save
      redirect_to price_by_weights_path, notice: 'Novo valor adicionado'
    else
      redirect_to price_by_weights_path,
                  alert: 'Não foi possível adicionar novo valor, os campos não podem ficar em branco'
    end
  end

  def edit
    @price_by_weight = PriceByWeight.find(params[:id])
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end

  def update
    @price_by_weight = PriceByWeight.find(params[:id])

    if @price_by_weight.update(price_by_weights_params)
      redirect_to price_by_weights_path, notice: 'Valor atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar'
      render 'edit'
    end
  end

  private

  def price_by_weights_params
    params.require(:price_by_weight).permit(:starting_weight, :final_weight, :price_per_km)
  end
end
