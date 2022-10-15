class HomeController < ApplicationController
  def index; end

  def search
    @order = OrderOfService.find_by('order_service_code LIKE ?', "%#{params[:query]}%")
  end
end
