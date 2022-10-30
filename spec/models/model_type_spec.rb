require 'rails_helper'

RSpec.describe ModelType, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o nome deve ser obrigatório' do
        model_type = ModelType.new(name: nil)
        model_type.valid?
        expect(model_type.errors.include?(:name)).to be true
      end

      it 'a distância inicial deve ser obrigatório' do
        model_type = ModelType.new(starting_km: nil)
        model_type.valid?
        expect(model_type.errors.include?(:starting_km)).to be true
      end

      it 'a distância inicial deve ser maior do que zero' do
        model_type = ModelType.new(starting_km: 0)
        model_type.valid?
        expect(model_type.errors.include?(:starting_km)).to be true
      end

      it 'a distância inicial deve ser um número inteiro' do
        model_type = ModelType.new(starting_km: 1.5)
        model_type.valid?
        expect(model_type.errors.include?(:starting_km)).to be true
      end

      it 'a distância final deve ser obrigatório' do
        model_type = ModelType.new(final_km: nil)
        model_type.valid?
        expect(model_type.errors.include?(:final_km)).to be true
      end

      it 'a distância final deve ser maior do que zero' do
        model_type = ModelType.new(final_km: 0)
        model_type.valid?
        expect(model_type.errors.include?(:final_km)).to be true
      end

      it 'a distância final deve ser um número inteiro' do
        model_type = ModelType.new(final_km: 1.5)
        model_type.valid?
        expect(model_type.errors.include?(:final_km)).to be true
      end

      it 'o tempo de entrega deve ser obrigaatório' do
        model_type = ModelType.new(deadline: nil)
        model_type.valid?
        expect(model_type.errors.include?(:deadline)).to be true
      end

      it 'o tempo de entrega deve ser maior do que zero' do
        model_type = ModelType.new(deadline: 0)
        model_type.valid?
        expect(model_type.errors.include?(:deadline)).to be true
      end

      it 'o tempo de entrega deve ser um número inteiro' do
        model_type = ModelType.new(deadline: 1.5)
        model_type.valid?
        expect(model_type.errors.include?(:deadline)).to be true
      end
    end
  end
end
