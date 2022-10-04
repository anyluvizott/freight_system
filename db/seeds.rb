# Criando algumas modalidades de transporte de exemplo:

transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                 minimum_weight: 1, maximum_weight: 3_000, tax: 150)

transp2 = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                 minimum_weight: 100, maximum_weight: 2_000, tax: 50)

transp3 = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 1, maximum_distance: 50,
                                 minimum_weight: 1, maximum_weight: 300, tax: 20)

transp4 = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                 minimum_weight: 1, maximum_weight: 40, tax: 10)

# Criando alguns veículos de exemplo:

truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                year_of_manufacture: 2016, maximum_weight: 3_000, transport_model: transp1)

utili1 = Carrier.create!(drivers_name: 'José Antonio', nameplate: 'DFS6D44',
                vehicle_model: 'Peugeot Partner Furgão 1.6 16V - Flex', vehicle_brand: 'Peugeot',
                year_of_manufacture: 2016, maximum_weight: 800, transport_model: transp2)

utili2 = Carrier.create!(drivers_name: 'Maria Joana', nameplate: 'ARF9K56',
                vehicle_model: 'Mercedes-Benz Vito 2.0 CGI Tourer 119 - Flex', vehicle_brand: 'Mercedes-Benz',
                year_of_manufacture: 2015, maximum_weight: 1_200, transport_model: transp2)

utili3 = Carrier.create!(drivers_name: 'André da Silva', nameplate: 'BCA8F23',
                vehicle_model: 'Mercedes-Benz Sprinter 2.2 CDI - Diesel', vehicle_brand: 'Mercedes-Benz',
                year_of_manufacture: 2016, maximum_weight: 2_000, transport_model: transp2)

utili4 = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transp2)

moto1 = Carrier.create!(drivers_name: 'Roberto Siqueira', nameplate: 'FDS5A44',
                vehicle_model: 'Triciclo Sousa Mod. TR 150', vehicle_brand: 'Sousa Motos',
                year_of_manufacture: 2018, maximum_weight: 300, transport_model: transp3)

moto2 = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'JKL6S15',
                vehicle_model: 'Triciclo Honda Tricargo CG 150 Titan', vehicle_brand: 'Honda',
                year_of_manufacture: 2010, maximum_weight: 250, transport_model: transp3)

bike1 = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: nil,
                vehicle_model: 'Bicicleta Cargueira Aro 26', vehicle_brand: 'Samy',
                year_of_manufacture: nil, maximum_weight: 40, transport_model: transp4)

bike2 = Carrier.create!(drivers_name: 'Josevaldo da Silva', nameplate: nil,
                vehicle_model: 'Bicicleta Cargueira Aro 26', vehicle_brand: 'Samy',
                year_of_manufacture: nil, maximum_weight: 40, transport_model: transp4)
