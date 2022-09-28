class TransportModelsController < ApplicationController

  def index
    @transport_models = TransportModel.all
  end

  def show
    @transport_models = TransportModel.find(params[:id])
  end

end
