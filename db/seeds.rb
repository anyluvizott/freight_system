# Criando Usuário Regular e Administrador:
admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador', status: :admin)

regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular', status: :regular)

# Criando algumas modalidades de transporte de exemplo:
transport_one = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 100, maximum_distance: 1000,
                                       minimum_weight: 1000, maximum_weight: 3000, tax: 150)

transport_two = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                       minimum_weight: 50, maximum_weight: 2000, tax: 50)

transport_three = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 10, maximum_distance: 200,
                                         minimum_weight: 1, maximum_weight: 300, tax: 20)

transport_four = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                        minimum_weight: 1, maximum_weight: 40, tax: 10)

# Criando alguns veículos de exemplo:
truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                        vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                        year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transport_one)

utility_one = Carrier.create!(drivers_name: 'José Antonio', nameplate: 'DFS6D44',
                              vehicle_model: 'Peugeot Partner Furgão 1.6 16V - Flex', vehicle_brand: 'Peugeot',
                              year_of_manufacture: 2016, maximum_weight: 800, transport_model: transport_two)

utility_two = Carrier.create!(drivers_name: 'Maria Joana', nameplate: 'ARF9K56',
                              vehicle_model: 'Mercedes-Benz Vito 2.0 CGI Tourer 119 - Flex', vehicle_brand: 'Mercedes-Benz',
                              year_of_manufacture: 2015, maximum_weight: 1200, transport_model: transport_two)

utility_three = Carrier.create!(drivers_name: 'André da Silva', nameplate: 'BCA8F23',
                                vehicle_model: 'Mercedes-Benz Sprinter 2.2 CDI - Diesel', vehicle_brand: 'Mercedes-Benz',
                                year_of_manufacture: 2016, maximum_weight: 2000, transport_model: transport_two)

utility_four = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                               vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                               year_of_manufacture: 2019, maximum_weight: 1500, transport_model: transport_two)

motorcycle_one = Carrier.create!(drivers_name: 'Roberto Siqueira', nameplate: 'FDS5A44',
                                 vehicle_model: 'Triciclo Sousa Mod. TR 150', vehicle_brand: 'Sousa Motos',
                                 year_of_manufacture: 2018, maximum_weight: 300, transport_model: transport_three)

motorcycle_two = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'JKL6S15',
                                 vehicle_model: 'Triciclo Honda Tricargo CG 150 Titan', vehicle_brand: 'Honda',
                                 year_of_manufacture: 2010, maximum_weight: 250, transport_model: transport_three)

bicycle_one = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: nil,
                              vehicle_model: 'Bicicleta Cargueira Aro 26', vehicle_brand: 'Samy',
                              year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport_four)

bicycle_two = Carrier.create!(drivers_name: 'Josevaldo da Silva', nameplate: nil,
                              vehicle_model: 'Bicicleta Cargueira Aro 26', vehicle_brand: 'Samy',
                              year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport_four)

# Criando algumas ordens de serviço de exemplo:
order_one = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

order_two = OrderOfService.create!(full_sender_address: 'Galpão Aeroporto Afonso Pena - Rua das Araras, 2000 - São José dos Pinhais PR',
                                   product_length: 31, product_width: 20, product_height: 11,
                                   recipient_full_address: 'Rua das Cegonhas, 2541 - Curitiba PR', recipients_name: 'Roberto Quintana',
                                   distance: 30, product_weight: 20)

order_three = OrderOfService.create!(full_sender_address: 'Galpão Artes & Brinquedos - Rua das Bonecas, 541 - Curitiba PR',
                                     product_length: 34, product_width: 27, product_height: 14,
                                     recipient_full_address: 'Rua Figueiredo Assunção, 786 - Colombro PR', recipients_name: 'Heloisa Fagundes',
                                     distance: 50, product_weight: 50)

order_four = OrderOfService.create!(full_sender_address: 'Galpão Materiais de Contrução - Rua Frederico Feijó, 854 - Pinhais PR',
                                    product_length: 200, product_width: 200, product_height: 200,
                                    recipient_full_address: 'Rua Joaquim da Peste - São Paulo SP', recipients_name: 'Roberto da Silva',
                                    distance: 400, product_weight: 2500)

order_five = OrderOfService.create!(full_sender_address: 'Galpão Surf & Praia - Avenida Manoel Ribas, 634 - Pinhais PR',
                                    product_length: 100, product_width: 100, product_height: 100,
                                    recipient_full_address: 'Rua das Formigas, 100 - Florianópolis SC', recipients_name: 'Joana Siqueira',
                                    distance: 315, product_weight: 30)

# Criando tabela de preço por peso:
first_line = PriceByWeight.create!(starting_weight: 0, final_weight: 10, price_per_km: 0.50)
second_line = PriceByWeight.create!(starting_weight: 11, final_weight: 50, price_per_km: 0.80)
third_line = PriceByWeight.create!(starting_weight: 51, final_weight: 100, price_per_km: 1.10)
fourth_line = PriceByWeight.create!(starting_weight: 101, final_weight: 1000, price_per_km: 1.75)
fifth_line = PriceByWeight.create!(starting_weight: 1000, final_weight: 3000, price_per_km: 2.10)

# Criando tabela de preço por distância:
line_one = PricePerDistance.create!(starting_km: 0, final_km: 50, fixed_price: 9)
line_two = PricePerDistance.create!(starting_km: 51, final_km: 150, fixed_price: 12)
line_three = PricePerDistance.create!(starting_km: 151, final_km: 500, fixed_price: 20)
line_four = PricePerDistance.create!(starting_km: 501, final_km: 1000, fixed_price: 25)