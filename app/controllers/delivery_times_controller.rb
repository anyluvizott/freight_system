class DeliveryTimesController < ApplicationController
  before_action :authenticate_user!

  def index
    @delivery_times = DeliveryTime.all
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)

    if @delivery_time.save
      redirect_to delivery_times_path, notice: 'Novo valor adicionado'
    else
      redirect_to delivery_times_path,
                  alert: 'Não foi possível adicionar novo valor'
    end
  end

  def edit
    @delivery_time = DeliveryTime.find(params[:id])
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end

  def update
    @delivery_time = DeliveryTime.find(params[:id])

    if @delivery_time.update(delivery_time_params)
      redirect_to delivery_times_path, notice: 'Valor atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar'
      render 'edit'
    end
  end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(:starting_km, :final_km, :deadline)
  end
end
