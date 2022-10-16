require 'rails_helper'

describe 'Usuário Comum busca por uma ordem de serviço' do
  it 'visitando a página inicial' do
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

  it 'com sucesso' do
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
end
