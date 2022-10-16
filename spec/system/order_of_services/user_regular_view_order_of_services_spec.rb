require 'rails_helper'

describe 'Usuário Regular visualiza as Ordens de Serviço' do
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

    expect(page).to have_content 'Ordens de Serviço'
    expect(page).to have_content 'Serviço ABCDEFG12345678'
    expect(page).to have_content 'Carga de 5kg para percorrer uma distância de 15km'
    expect(page).to have_content 'Saindo de Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR para o destino de Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Status: Pendente'
  end

  it 'e não tem acesso ao cadastro de nova ordem de serviço' do
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

    expect(page).to have_content 'Serviço ABCDEFG12345678'
    expect(page).to have_content 'Carga de 5kg para percorrer uma distância de 15km'
    expect(page).to have_content 'Saindo de Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR para o destino de Rua das Laranjas, 253 - Curitiba PR'
    expect(page).not_to have_content 'Nova Ordem de Serviço'
  end
end
