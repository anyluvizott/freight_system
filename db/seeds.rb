# Criando algumas modalidades de transporte de exemplo:

TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                       minimum_weight: 1, maximum_weight: 3_000)

TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                       minimum_weight: 100, maximum_weight: 1_200)

TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 1, maximum_distance: 50,
                       minimum_weight: 1, maximum_weight: 160)
