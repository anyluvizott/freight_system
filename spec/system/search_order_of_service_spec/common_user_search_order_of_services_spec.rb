require 'rails_helper'

describe 'Usuário Comum faz uma busca' do
  it 'a partir da pagina inicial' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    visit root_path

    expect(page).to have_content 'Boas-Vindas à Transportadora AML'
    expect(page).to have_content 'Para buscar pela sua entrega, informe o código da Ordem de Serviço'
    expect(page).to have_button 'Buscar'
  end

  it 'para um produto em status pendente' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    visit root_path
    fill_in 'Buscar Entrega',	with: 'ABCDEFG12345678'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca'
    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Flora Mendes'
    expect(page).to have_content 'Status: Pendente'
  end

  it 'para um produto com status em rota de entrega' do
    transport = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                       minimum_weight: 1, maximum_weight: 40, tax: 10)

    bicycle = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: 'BIKEMARAMA',
                              vehicle_model: 'Bicicleta Cargueira Aro 26 Amarela', vehicle_brand: 'Samy',
                              year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5, status: :on_route, delivery_date: 1.day.ago)

    start_order_five = StartServiceOrder.create!(order_of_service_id: 1, carrier_id: 1, delivery_type: 'comum')

    visit root_path
    fill_in 'Buscar Entrega',	with: 'ABCDEFG12345678'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca'
    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Flora Mendes'
    expect(page).to have_content "Data de Saída: #{I18n.l(order.delivery_date, format: '%d de %B de %Y')}"
    expect(page).to have_content 'Informações do Veículo'
    expect(page).to have_content 'Motorista: Marcelo Ferreira'
    expect(page).to have_content 'Placa de Identificação: '
    expect(page).to have_content 'Modelo do Veículo: Bicicleta Cargueira Aro 26 Amarela'
    expect(page).to have_content 'Status: Em Rota de Entrega'
    expect(page).not_to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Status: Entregue'
  end

  it 'para um produto com status entregue dentro do prazo' do
    transport = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                       minimum_weight: 1, maximum_weight: 40, tax: 10)

    bicycle = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: 'BIKEMARAMA',
                              vehicle_model: 'Bicicleta Cargueira Aro 26 Amarela', vehicle_brand: 'Samy',
                              year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5, status: :delivered, delivery_date: 2.days.ago, final_date: 1.day.ago)

    start_order_five = StartServiceOrder.create!(order_of_service_id: 1, carrier_id: 1, delivery_type: 'comum')

    visit root_path
    fill_in 'Buscar Entrega',	with: 'ABCDEFG12345678'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca'
    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Flora Mendes'
    expect(page).to have_content "Data de Entrega: #{I18n.l(order.final_date, format: '%d de %B de %Y')}"
    expect(page).to have_content 'Informações do Veículo'
    expect(page).to have_content 'Motorista: Marcelo Ferreira'
    expect(page).to have_content 'Placa de Identificação: '
    expect(page).to have_content 'Modelo do Veículo: Bicicleta Cargueira Aro 26 Amarela'
    expect(page).to have_content 'Entrega foi realizada dentro do prazo'
    expect(page).to have_content 'Status: Entregue'
    expect(page).not_to have_content 'Status: Em Rota de Entrega'
    expect(page).not_to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Entrega realizada com atraso'

  end

  it 'para um produto com status entregue com atraso' do
    transport = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                       minimum_weight: 1, maximum_weight: 40, tax: 10)

    bicycle = Carrier.create!(drivers_name: 'Marcelo Ferreira', nameplate: 'BIKEMARAMA',
                              vehicle_model: 'Bicicleta Cargueira Aro 26 Amarela', vehicle_brand: 'Samy',
                              year_of_manufacture: 2010, maximum_weight: 40, transport_model: transport)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5, status: :delivered, delivery_date: 4.days.ago, final_date: 1.day.ago, note: 'Acidente no caminho para o destino')

    start_order_five = StartServiceOrder.create!(order_of_service_id: 1, carrier_id: 1, delivery_type: 'comum')

    visit root_path
    fill_in 'Buscar Entrega',	with: 'ABCDEFG12345678'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca'
    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Flora Mendes'
    expect(page).to have_content "Data de Entrega: #{I18n.l(order.final_date, format: '%d de %B de %Y')}"
    expect(page).to have_content 'Informações do Veículo'
    expect(page).to have_content 'Motorista: Marcelo Ferreira'
    expect(page).to have_content 'Placa de Identificação: '
    expect(page).to have_content 'Modelo do Veículo: Bicicleta Cargueira Aro 26 Amarela'
    expect(page).to have_content 'Entrega realizada com atraso'
    expect(page).to have_content 'Motivo: Acidente no caminho para o destino'
    expect(page).to have_content 'Status: Entregue'
    expect(page).not_to have_content 'Status: Em Rota de Entrega'
    expect(page).not_to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Entrega foi realizada dentro do prazo'

  end
end
