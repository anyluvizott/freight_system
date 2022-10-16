require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o km inicial deve ser obrigatório' do
        deadline = DeliveryTime.new(starting_km: nil)
        deadline.valid?
        expect(deadline.errors.include?(:starting_km)).to be true
      end

      it 'o km inicial deve ser maior do que zero' do
        deadline = DeliveryTime.new(starting_km: 0)
        deadline.valid?
        expect(deadline.errors.include?(:starting_km)).to be true
      end

      it 'o km inicial deve ser um número inteiro' do
        deadline = DeliveryTime.new(starting_km: 1.5)
        deadline.valid?
        expect(deadline.errors.include?(:starting_km)).to be true
      end

      it 'o km final deve ser obrigatório' do
        deadline = DeliveryTime.new(final_km: nil)
        deadline.valid?
        expect(deadline.errors.include?(:final_km)).to be true
      end

      it 'o km final deve ser maior do que zero' do
        deadline = DeliveryTime.new(final_km: 0)
        deadline.valid?
        expect(deadline.errors.include?(:final_km)).to be true
      end

      it 'o km final deve ser um número inteiro' do
        deadline = DeliveryTime.new(final_km: 1.5)
        deadline.valid?
        expect(deadline.errors.include?(:final_km)).to be true
      end

      it 'o prazo de entrega deve ser obrigatório' do
        deadline = DeliveryTime.new(deadline: nil)
        deadline.valid?
        expect(deadline.errors.include?(:deadline)).to be true
      end

      it 'o prazo de entrega deve ser maior do que zero' do
        deadline = DeliveryTime.new(deadline: 0)
        deadline.valid?
        expect(deadline.errors.include?(:deadline)).to be true
      end

      it 'o prazo de entrega deve ser um número inteiro' do
        deadline = DeliveryTime.new(deadline: 1.5)
        deadline.valid?
        expect(deadline.errors.include?(:deadline)).to be true
      end
    end
  end
end
