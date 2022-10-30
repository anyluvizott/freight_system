class ModelTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :restriction_for_regular_user

  def show
    @model_type = ModelType.find(params[:id])
  end

  def new
    @model_type = ModelType.new
    @transport_models = TransportModel.all
  end

  def create
    @model_type = ModelType.new(model_type_params)

    if @model_type.save
      redirect_to model_type_path(@model_type), notice: 'Novo Tipo de Modalidade de Entrega cadastrada com sucesso'
    else
      @transport_models = TransportModel.all
      flash.now[:alert] = 'Não foi possível adicionar o Tipo de Modalidade de Entrega'
      render 'new'
    end
  end

  def edit
    @model_type = ModelType.find(params[:id])
  end

  def update
    @model_type = ModelType.find(params[:id])

    if @model_type.update(model_type_params)
      redirect_to @model_type, notice: 'Tipo de Modelo de Entrega atualizado com sucesso'
    else

      flash.now[:alert] = 'Não foi possível atualizar'
      render 'edit'
    end
  end

  private

  def model_type_params
    params.require(:model_type).permit(:name, :starting_km, :final_km, :deadline, :transport_model_id)
  end

  def restriction_for_regular_user
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end
end
