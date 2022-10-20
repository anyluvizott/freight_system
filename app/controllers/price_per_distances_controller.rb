class PricePerDistancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @price_per_distances = PricePerDistance.all
    @price_per_distance = PricePerDistance.new
  end

  def create
    @price_per_distance = PricePerDistance.new(price_per_distances_params)

    if @price_per_distance.save
      redirect_to price_per_distances_path, notice: 'Novo valor adicionado'
    else
      redirect_to price_per_distances_path,
                  alert: 'Não foi possível adicionar novo valor'
    end
  end

  def edit
    @price_per_distance = PricePerDistance.find(params[:id])
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end

  def update
    @price_per_distance = PricePerDistance.find(params[:id])

    if @price_per_distance.update(price_per_distances_params)
      redirect_to price_per_distances_path, notice: 'Valor atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar'
      render 'edit'
    end
  end

  private

  def price_per_distances_params
    params.require(:price_per_distance).permit(:starting_km, :final_km, :fixed_price)
  end
end
