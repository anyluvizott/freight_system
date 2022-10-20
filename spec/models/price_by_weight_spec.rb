require 'rails_helper'

RSpec.describe PriceByWeight, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o peso inicial deve ser obrigatório' do
        price_by_weight = PriceByWeight.new(starting_weight: nil)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:starting_weight)).to be true
      end

      it 'o peso inicial deve ser maior do que zero' do
        price_by_weight = PriceByWeight.new(starting_weight: 0)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:starting_weight)).to be true
      end

      it 'o peso inicial deve ser um número inteiro' do
        price_by_weight = PriceByWeight.new(starting_weight: 1.5)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:starting_weight)).to be true
      end

      it 'o peso inicial deve ser menor do que o peso final' do
        price_by_weight = PriceByWeight.new(starting_weight: 10, final_weight: 5)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:starting_weight)).to be true
      end

      it 'o peso final deve ser obrigatório' do
        price_by_weight = PriceByWeight.new(final_weight: nil)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:final_weight)).to be true
      end

      it 'o peso final deve ser maior do que zero' do
        price_by_weight = PriceByWeight.new(final_weight: 0)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:final_weight)).to be true
      end

      it 'o peso final deve ser um número inteiro' do
        price_by_weight = PriceByWeight.new(final_weight: 1.5)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:final_weight)).to be true
      end

      it 'o preço por km deve ser obrigatório' do
        price_by_weight = PriceByWeight.new(price_per_km: nil)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:price_per_km)).to be true
      end

      it 'o preço por km deve ser maior do que zero' do
        price_by_weight = PriceByWeight.new(price_per_km: 0)
        price_by_weight.valid?
        expect(price_by_weight.errors.include?(:price_per_km)).to be true
      end
    end
  end
end
