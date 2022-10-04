require 'rails_helper'

RSpec.describe TransportModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando o nome estiver vazio' do
        model = TransportModel.new(name: '', minimum_distance: 1, maximum_distance: 600, minimum_weight: 1,
                                   maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando a distancia minima estiver vazia' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: nil, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando a distancia maxima estiver vazia' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: nil,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando o peso minimo estiver vazio' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: nil, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando o peso maximo estiver vazio' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: nil)

        result = model.valid?

        expect(result).to eq false
      end

      it 'taxa fixa de entrega deve ser obrigatória' do
        transp = TransportModel.new(tax: nil)

        transp.valid?
        expect(transp.errors.include?(:tax)).to be true
      end

      it 'falso quando a taxa fixa de entrega é zero' do
        transp = TransportModel.new(tax: 0)

        transp.valid?
        expect(transp.errors.include?(:tax)).to be true
      end

      it 'falso quando a taxa fixa de entrega é menor do que zero' do
        transp = TransportModel.new(tax: -1)

        transp.valid?
        expect(transp.errors.include?(:tax)).to be true
      end

      it 'falso quando a distancia minima é zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 0, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando a distancia minima é menor do que zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: -1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando a distancia maxima é zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 0,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando a distancia maxima é menor do que zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: -1,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando o peso minimo é zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 0, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando o peso minimo é menor do que zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: -1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando o peso máximo é zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 0)

        result = model.valid?

        expect(result).to eq false
      end

      it 'falso quando o peso máximo é menor do que zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: -1)

        result = model.valid?

        expect(result).to eq false
      end
    end
  end
end
