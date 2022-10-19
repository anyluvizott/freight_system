require 'rails_helper'

describe 'Usuário Autenticado busca uma Ordem de Serviço dentro do index da OS' do
  it 'pelo endereço do remetente' do
    order_one = OrderOfService.create!(full_sender_address: 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR',
                                       product_length: 30, product_width: 20, product_height: 8,
                                       recipient_full_address: 'Rua dos Papagaios, 805 - Curitiba PR', recipients_name: 'Caio Vidal',
                                       distance: 30, product_weight: 15)

    order_two = OrderOfService.create!(full_sender_address: 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR',
                                       product_length: 50, product_width: 25, product_height: 25,
                                       recipient_full_address: 'Avenida das Flores, 27 - Curitiba PR', recipients_name: 'Tony Hitoshi',
                                       distance: 25, product_weight: 20)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço',	with: 'Cantinho'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da Buscar por: Cantinho'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR'
    expect(page).to have_content 'Código do Produto:'
    expect(page).to have_content 'Dimensões da Carga: 30cm x 20cm x 8cm'
    expect(page).to have_content 'Peso da Carga: 15kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua dos Papagaios, 805 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Caio Vidal'
    expect(page).to have_content 'Distância que a carga vai percorrer: 30km'
    expect(page).to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR'
    expect(page).not_to have_content 'Avenida das Flores, 27 - Curitiba PR'
    expect(page).not_to have_content 'Tony Hitoshi'
  end

  it 'pelo endereço do destinatário' do
    order_one = OrderOfService.create!(full_sender_address: 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR',
                                       product_length: 30, product_width: 20, product_height: 8,
                                       recipient_full_address: 'Rua dos Papagaios, 805 - Curitiba PR', recipients_name: 'Caio Vidal',
                                       distance: 30, product_weight: 15)

    order_two = OrderOfService.create!(full_sender_address: 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR',
                                       product_length: 50, product_width: 25, product_height: 25,
                                       recipient_full_address: 'Avenida das Flores, 27 - Curitiba PR', recipients_name: 'Tony Hitoshi',
                                       distance: 25, product_weight: 20)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço',	with: 'Flores'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da Buscar por: Flores'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR'
    expect(page).to have_content 'Código do Produto:'
    expect(page).to have_content 'Dimensões da Carga: 50cm x 25cm x 25cm'
    expect(page).to have_content 'Peso da Carga: 20kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Avenida das Flores, 27 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Tony Hitoshi'
    expect(page).to have_content 'Distância que a carga vai percorrer: 25km'
    expect(page).to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR'
    expect(page).not_to have_content 'Rua dos Papagaios, 805 - Curitiba PR'
    expect(page).not_to have_content 'Caio Vidal'
  end

  it 'pelo nome do destinatário' do
    order_one = OrderOfService.create!(full_sender_address: 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR',
                                       product_length: 30, product_width: 20, product_height: 8,
                                       recipient_full_address: 'Rua dos Papagaios, 805 - Curitiba PR', recipients_name: 'Caio Vidal',
                                       distance: 30, product_weight: 15)

    order_two = OrderOfService.create!(full_sender_address: 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR',
                                       product_length: 50, product_width: 25, product_height: 25,
                                       recipient_full_address: 'Avenida das Flores, 27 - Curitiba PR', recipients_name: 'Tony Hitoshi',
                                       distance: 25, product_weight: 20)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço',	with: 'Caio'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da Buscar por: Caio'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR'
    expect(page).to have_content 'Código do Produto:'
    expect(page).to have_content 'Dimensões da Carga: 30cm x 20cm x 8cm'
    expect(page).to have_content 'Peso da Carga: 15kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua dos Papagaios, 805 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Caio Vidal'
    expect(page).to have_content 'Distância que a carga vai percorrer: 30km'
    expect(page).to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR'
    expect(page).not_to have_content 'Avenida das Flores, 27 - Curitiba PR'
    expect(page).not_to have_content 'Tony Hitoshi'
  end

  it 'pelo código da ordem de serviço' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('HIJKLMN98765432')
    order_one = OrderOfService.create!(full_sender_address: 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR',
                                       product_length: 30, product_width: 20, product_height: 8,
                                       recipient_full_address: 'Rua dos Papagaios, 805 - Curitiba PR', recipients_name: 'Caio Vidal',
                                       distance: 30, product_weight: 15)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order_two = OrderOfService.create!(full_sender_address: 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR',
                                       product_length: 50, product_width: 25, product_height: 25,
                                       recipient_full_address: 'Avenida das Flores, 27 - Curitiba PR', recipients_name: 'Tony Hitoshi',
                                       distance: 25, product_weight: 20)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço',	with: 'ABCDEFG12345678'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da Buscar por: ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR'
    expect(page).to have_content 'Código do Produto:'
    expect(page).to have_content 'Dimensões da Carga: 50cm x 25cm x 25cm'
    expect(page).to have_content 'Peso da Carga: 20kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Avenida das Flores, 27 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Tony Hitoshi'
    expect(page).to have_content 'Distância que a carga vai percorrer: 25km'
    expect(page).to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR'
    expect(page).not_to have_content 'Rua dos Papagaios, 805 - Curitiba PR'
    expect(page).not_to have_content 'Caio Vidal'
  end

  it 'pelo código do produto' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('UEF9G')
    order_one = OrderOfService.create!(full_sender_address: 'Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR',
                                       product_length: 30, product_width: 20, product_height: 8,
                                       recipient_full_address: 'Rua dos Papagaios, 805 - Curitiba PR', recipients_name: 'Caio Vidal',
                                       distance: 30, product_weight: 15)

    allow(SecureRandom).to receive(:alphanumeric).and_return('AEF2L')
    order_two = OrderOfService.create!(full_sender_address: 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR',
                                       product_length: 50, product_width: 25, product_height: 25,
                                       recipient_full_address: 'Avenida das Flores, 27 - Curitiba PR', recipients_name: 'Tony Hitoshi',
                                       distance: 25, product_weight: 20)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço',	with: 'UEF9G'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da Buscar por: UEF9G'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Cantinho da Tia Anastácia - Rua Palmeiras do Havaí, 50 - Curitiba PR'
    expect(page).to have_content 'Código do Produto:'
    expect(page).to have_content 'Dimensões da Carga: 30cm x 20cm x 8cm'
    expect(page).to have_content 'Peso da Carga: 15kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua dos Papagaios, 805 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Caio Vidal'
    expect(page).to have_content 'Distância que a carga vai percorrer: 30km'
    expect(page).to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Mercado dos Anões - Rua Jardim Encantado, 200 - Curitiba PR'
    expect(page).not_to have_content 'Avenida das Flores, 27 - Curitiba PR'
    expect(page).not_to have_content 'Tony Hitoshi'
  end
end
