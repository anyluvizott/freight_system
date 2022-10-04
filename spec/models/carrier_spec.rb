require 'rails_helper'

RSpec.describe Carrier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o nome do motorista deve ser obrigatório' do
        utili = Carrier.new(drivers_name: nil)
        utili.valid?
        expect(utili.errors.include?(:drivers_name)).to be true
      end

      it 'o modelo do veículo deve ser obrigatório' do
        utili = Carrier.new(vehicle_model: nil)
        utili.valid?
        expect(utili.errors.include?(:vehicle_model)).to be true
      end

      it 'a marca do veículo deve ser obrigatória' do
        utili = Carrier.new(vehicle_brand: nil)
        utili.valid?
        expect(utili.errors.include?(:vehicle_brand)).to be true
      end

      it 'o peso máximo deve ser obrigatório' do
        utili = Carrier.new(maximum_weight: nil)
        utili.valid?
        expect(utili.errors.include?(:maximum_weight)).to be true
      end

      it 'o peso máximo deve ser maior do que zero' do
        utili = Carrier.new(maximum_weight: 0)
        utili.valid?
        expect(utili.errors.include?(:maximum_weight)).to be true
      end

      it 'o ano de fabricação deve ser um número inteiro' do
        utili = Carrier.new(year_of_manufacture: 12.5)
        utili.valid?
        expect(utili.errors.include?(:year_of_manufacture)).to be true
      end

      it 'o ano de fabricação deve ser obrigatório' do
        utili = Carrier.new(year_of_manufacture: nil)
        utili.valid?
        expect(utili.errors.include?(:year_of_manufacture)).to be true
      end

      it 'o ano de fabricação deve ser maior do que zero' do
        utili = Carrier.new(year_of_manufacture: 0)
        utili.valid?
        expect(utili.errors.include?(:year_of_manufacture)).to be true
      end

      it 'o ano de fabricação deve ter 4 caracteres' do
        utili = Carrier.new(year_of_manufacture: 199)
        utili.valid?
        expect(utili.errors.include?(:year_of_manufacture)).to be true
      end
    end
  end
end
