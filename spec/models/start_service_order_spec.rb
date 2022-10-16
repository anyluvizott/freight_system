require 'rails_helper'

RSpec.describe StartServiceOrder, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o tipo de entrega deve ser obrigatório' do
        start_service = StartServiceOrder.new(delivery_type: nil)
        start_service.valid?
        expect(start_service.errors.include?(:delivery_type)).to be true
      end
    end
  end
end