require 'rails_helper'

describe 'Usuário Regular visualiza os detalhes da Ordens de Serviço' do
  it 'a partir do menu' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
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
  end

  it 'e não tem acesso a edição da ordem de serviço' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
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
    expect(page).not_to have_link 'Editar Ordem de Serviço'
  end
end
