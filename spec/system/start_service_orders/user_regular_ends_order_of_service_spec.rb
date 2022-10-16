require 'rails_helper'

describe 'Usuário Regular encerra uma ordem de serviço' do
  it 'a partir do menu' do
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
    select 'Rodoviário - Motocicleta - Triciclo Honda Tricargo CG 150 Titan', from: 'Veículos para Entrega'
    choose 'Entrega Comum'
    click_on 'Confirmar Entrega'
    click_on 'Marcar como Entregue'

    expect(page).to have_content 'Status: Entregue'
    expect(page).not_to have_content 'Status: Pendente'
    expect(page).to have_content 'Ordem de Serviço Concluída!'
    expect(page).to have_content 'Detalhes:'
    expect(page).to have_content 'Entrega: Comum'
    expect(page).to have_content 'Valor Total da Entrega: R$ 36,50'
    expect(page).to have_content 'Prazo de Entrega: 48 horas'
  end
end
