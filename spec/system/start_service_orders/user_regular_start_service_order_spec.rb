require 'rails_helper'

describe 'Usuário Regular inicia uma Ordem de Serviço' do
  it 'a partir do menu' do
    transport_two = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                           minimum_weight: 50, maximum_weight: 2000, tax: 50)

    transport_three = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 10, maximum_distance: 200,
                                             minimum_weight: 1, maximum_weight: 300, tax: 20)

    transport_four = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                            minimum_weight: 1, maximum_weight: 40, tax: 10)

    utility_four = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                                   vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                                   year_of_manufacture: 2019, maximum_weight: 1500, transport_model: transport_two)

    motorcycle_one = Carrier.create!(drivers_name: 'Roberto Siqueira', nameplate: 'FDS5A44',
                                     vehicle_model: 'Triciclo Sousa Mod. TR 150', vehicle_brand: 'Sousa Motos',
                                     year_of_manufacture: 2018, maximum_weight: 300, transport_model: transport_three)

    motorcycle_two = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'JKL6S15',
                                     vehicle_model: 'Triciclo Honda Tricargo CG 150 Titan', vehicle_brand: 'Honda',
                                     year_of_manufacture: 2010, maximum_weight: 250, transport_model: transport_three)

    bicycle_one = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: 'BIKEMARAMA',
                                  vehicle_model: 'Bicicleta Cargueira Aro 26 Amarela', vehicle_brand: 'Samy',
                                  year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport_four)

    bicycle_two = Carrier.create!(drivers_name: 'Josevaldo da Silva', nameplate: 'BIKEJOSVER',
                                  vehicle_model: 'Bicicleta Cargueira Aro 26 Verde', vehicle_brand: 'Samy',
                                  year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport_four)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order_one = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                       product_length: 25, product_width: 17, product_height: 8,
                                       recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                       distance: 15, product_weight: 5)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'ABCDEFG12345678'

    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR'
    expect(page).to have_content 'Dimensões da Carga: 25cm x 17cm x 8cm'
    expect(page).to have_content 'Peso da Carga: 5kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Flora Mendes'
    expect(page).to have_content 'Distância que a carga vai percorrer: 15km'
    expect(page).to have_content 'Status: Pendente'
    expect(page).to have_link 'Voltar'
    expect(page).to have_content 'Realizar Entrega'
    expect(page).to have_content 'Valor da Entrega'
    expect(page).to have_content 'Modalidade de Entrega:'
    expect(page).to have_content 'Entrega Comum:'
    expect(page).to have_content 'Entrega Expressa:'
    expect(page).to have_content 'Entrega Super Expressa:'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '48 horas'
    expect(page).to have_content '36 horas'
    expect(page).to have_content '24 horas'
    expect(page).to have_content 'Rodoviário - Motocicleta'
    expect(page).to have_content 'R$ 36,50'
    expect(page).to have_content 'R$ 45,63'
    expect(page).to have_content 'R$ 54,75'
    expect(page).to have_content 'Rodoviário - Bicicleta'
    expect(page).to have_content 'R$ 26,50'
    expect(page).to have_content 'R$ 33,13'
    expect(page).to have_content 'R$ 39,75'
    expect(page).to have_content 'Veículos para Entrega'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content 'Entrega Expressa'
    expect(page).to have_content 'Entrega Super Expressa'
    expect(page).to have_button 'Confirmar Entrega'
  end

  it 'com sucesso' do
    transport_three = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 10, maximum_distance: 200,
                                             minimum_weight: 1, maximum_weight: 300, tax: 20)

    transport_four = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                            minimum_weight: 1, maximum_weight: 40, tax: 10)

    motorcycle_two = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'JKL6S15',
                                     vehicle_model: 'Triciclo Honda Tricargo CG 150 Titan', vehicle_brand: 'Honda',
                                     year_of_manufacture: 2010, maximum_weight: 250, transport_model: transport_three)

    bicycle_one = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: 'BIKEMARAMA',
                                  vehicle_model: 'Bicicleta Cargueira Aro 26 Amarela', vehicle_brand: 'Samy',
                                  year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport_four)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order_one = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                       product_length: 25, product_width: 17, product_height: 8,
                                       recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                       distance: 15, product_weight: 5)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'ABCDEFG12345678'
    select 'Rodoviário - Motocicleta - Triciclo Honda Tricargo CG 150 Titan', from: 'Veículos para Entrega'
    choose 'Entrega Comum'
    click_on 'Confirmar Entrega'

    expect(page).to have_content 'Status: Em Rota de Entrega'
    expect(page).to have_content 'Ordem de Serviço já está em rota de entrega!'
    expect(page).to have_content 'Entrega em Rota'
    expect(page).to have_content 'Detalhes:'
    expect(page).to have_content 'Entrega: Comum'
    expect(page).to have_content 'Valor Total da Entrega: R$ 36,50'
    expect(page).to have_content 'Prazo de Entrega: 48 horas'
    expect(page).to have_button 'Marcar como Entregue'

  end

  it 'sem informar a modalidade da entrega' do
    transport_three = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 10, maximum_distance: 200,
                                             minimum_weight: 1, maximum_weight: 300, tax: 20)

    motorcycle_two = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'JKL6S15',
                                     vehicle_model: 'Triciclo Honda Tricargo CG 150 Titan', vehicle_brand: 'Honda',
                                     year_of_manufacture: 2010, maximum_weight: 250, transport_model: transport_three)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order_one = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                       product_length: 25, product_width: 17, product_height: 8,
                                       recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                       distance: 15, product_weight: 5)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'ABCDEFG12345678'
    click_on 'Confirmar Entrega'

    expect(page).to have_content 'Status: Pendente'
    expect(page).to have_content 'Entrega não concluída'
    expect(page).not_to have_content 'Status: Em Rota de Entrega'
    expect(page).not_to have_content 'Ordem de Serviço já está em rota de entrega!'
  end
end
