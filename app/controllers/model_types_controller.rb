class ModelTypeController < ApplicationController
  before_action :authenticate_user!
  before_action :restriction_for_regular_user

  def new
    @model_type = ModelType.new
    @transport_models = TransportModel.all
  end

  def create
    @model_type = ModelType.new(model_type_params)

    if @model_type.save
      redirect_to new_model_type_path, notice: "Novo Tipo de Modalidade adicionado com sucesso"
    else
      redirect_to new_model_type_path, alert: "Não foi possível adicionar o Tipo de Modalidade"
  end

  def edit

  end

  def update

  end

  private 

  def model_type_params
    params.require(:model_type).permit(:name, :starting_km, :final_km, :deadline, :transport_model_id)
  end

  def restriction_for_regular_user
    redirect_to root_path, alert: 'Você não possui autorização para acessar essa página.' if current_user.regular?
  end

end