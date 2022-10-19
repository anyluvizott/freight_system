class TransportModelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transport_models = TransportModel.all
  end

  def show
    @transport_model = TransportModel.find(params[:id])
  end

  def new
    @transport_model = TransportModel.new
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end

  def create
    @transport_model = TransportModel.new(transport_model_params)
    if @transport_model.save
      redirect_to @transport_model, notice: 'Modalidade de Transporte cadastrada com sucesso'
    else
      flash.now[:alert] = 'Modalidade de Transporte não cadastrada'
      render 'new'
    end
  end

  def edit
    @transport_model = TransportModel.find(params[:id])
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end

  def update
    @transport_model = TransportModel.find(params[:id])
    if @transport_model.update(transport_model_params)
      redirect_to transport_model_path(@transport_model.id), notice: 'Modalidade Atualizada com Sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar'
      render 'edit'
    end
  end

  private

  def transport_model_params
    params.require(:transport_model).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight,
                                            :maximum_weight, :tax)
  end
end
