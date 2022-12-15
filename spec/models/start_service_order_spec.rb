require 'rails_helper'

RSpec.describe StartServiceOrder, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o tipo de entrega deve ser obrigatório' do
        start_service = StartServiceOrder.new(model_type_id: nil)
        start_service.valid?
        expect(start_service.errors.include?(:model_type_id)).to be true
      end

      it 'o veículo deve ser obrigatório' do
        start_service = StartServiceOrder.new(carrier_id: nil)
        start_service.valid?
        expect(start_service.errors.include?(:carrier_id)).to be true
      end
    end
  end
end