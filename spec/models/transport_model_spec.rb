require 'rails_helper'

RSpec.describe TransportModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        model = TransportModel.new(name: '', minimum_distance: 1, maximum_distance: 600, minimum_weight: 1,
                                   maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when minimum distance is empty' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: nil, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when maximum distance is empty' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: nil,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when minimum weight is empty' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: nil, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when maximum weight is empty' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: nil)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when minimum distance is zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 0, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when minimum distance is less than zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: -1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when maximum distance is zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 0,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when maximum distance is less than zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: -1,
                                   minimum_weight: 1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when minimum weight is zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 0, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when minimum weight is less than zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: -1, maximum_weight: 3_000)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when maximum weight is zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: 0)

        result = model.valid?

        expect(result).to eq false
      end

      it 'false when maximum weight is less than zero' do
        model = TransportModel.new(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                   minimum_weight: 1, maximum_weight: -1)

        result = model.valid?

        expect(result).to eq false
      end
    end
  end
end
