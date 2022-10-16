require 'rails_helper'

RSpec.describe PricePerDistance, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o km inicial deve ser obrigatório' do
        price_per_distance = PricePerDistance.new(starting_km: nil)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:starting_km)).to be true
      end

      it 'o km inicial deve ser maior do que zero' do
        price_per_distance = PricePerDistance.new(starting_km: 0)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:starting_km)).to be true
      end

      it 'o km inicial deve ser um número inteiro' do
        price_per_distance = PricePerDistance.new(starting_km: 1.5)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:starting_km)).to be true
      end

      it 'o km final deve ser obrigatório' do
        price_per_distance = PricePerDistance.new(final_km: nil)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:final_km)).to be true
      end

      it 'o km final deve ser maior do que zero' do
        price_per_distance = PricePerDistance.new(final_km: 0)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:final_km)).to be true
      end

      it 'o km final deve ser um número inteiro' do
        price_per_distance = PricePerDistance.new(final_km: 1.5)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:final_km)).to be true
      end

      it 'o preço fixo deve ser obrigatório' do
        price_per_distance = PricePerDistance.new(fixed_price: nil)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:fixed_price)).to be true
      end

      it 'o preço fixo deve ser maior do que zero' do
        price_per_distance = PricePerDistance.new(fixed_price: 0)
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:fixed_price)).to be true
      end
    end
  end
end
