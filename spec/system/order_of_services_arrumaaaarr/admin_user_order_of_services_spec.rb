require 'rails_helper'

describe 'Usuário Administrador visualiza as Ordens de Serviço' do
  it 'a partir do menu' do
    # Arrange
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    # Act
    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'

    # Assert
    expect(page).to have_content 'Serviço ABCDEFG12345678'
    expect(page).to have_content 'Carga de 5kg para percorrer uma distância de 15km'
    expect(page).to have_content 'Saindo de Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR para o destino de Rua das Laranjas, 253 - Curitiba PR'
    expect(page).to have_content 'Nova Ordem de Serviço'
  end
end

describe 'Usuário Administrador cadastra uma nova ordem de serviço' do
  it 'com sucesso' do
    # Arrange
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')

    # Act
    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'Nova Ordem de Serviço'

    fill_in 'Endereço Completo de Saída',	with: 'Galpão das Rosas, 12 - Curitiba PR'
    fill_in 'Peso do Produto em kg',	with: '2'
    fill_in 'Altura do Produto em cm',	with: '30'
    fill_in 'Largura do Produto em cm',	with: '5'
    fill_in 'Comprimento do Produto em cm',	with: '5'
    fill_in 'Endereço Completo do Destinatário',	with: 'Rua Beija-Flor, 58 - Curitiba PR'
    fill_in 'Nome do Destinatário',	with: 'Cecília Flores'
    fill_in 'Distância em km',	with: '15'

    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Ordem de Serviço Cadastrada'
    expect(page).not_to have_content 'Não foi possível cadastrar Ordem de Serviço'

    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Rosas, 12 - Curitiba PR'
    expect(page).to have_content 'Dimensões da Carga: 5cm x 5cm x 30cm'
    expect(page).to have_content 'Peso da Carga: 2kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua Beija-Flor, 58 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Cecília Flores'
    expect(page).to have_content 'Distância que a carga vai percorrer: 15km'

    expect(page).to have_content 'Editar Ordem de Serviço'
    expect(page).to have_link 'Voltar'
  end

  it 'com dados incompletos' do
    # Arrange
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    # Act
    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'Nova Ordem de Serviço'

    fill_in 'Endereço Completo de Saída',	with: nil
    fill_in 'Peso do Produto em kg',	with: nil
    fill_in 'Altura do Produto em cm',	with: nil
    fill_in 'Largura do Produto em cm',	with: nil
    fill_in 'Comprimento do Produto em cm',	with: nil
    fill_in 'Endereço Completo do Destinatário',	with: nil
    fill_in 'Nome do Destinatário',	with: nil
    fill_in 'Distância em km',	with: nil

    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível cadastrar Ordem de Serviço'
    expect(page).not_to have_content 'Ordem de Serviço Cadastrada'

    expect(page).to have_content 'Endereço Completo de Saída não pode ficar em branco'
    expect(page).to have_content 'Altura do Produto em cm não pode ficar em branco'
    expect(page).to have_content 'Largura do Produto em cm não pode ficar em branco'
    expect(page).to have_content 'Comprimento do Produto em cm não pode ficar em branco'
    expect(page).to have_content 'Peso do Produto em kg não pode ficar em branco'
    expect(page).to have_content 'Endereço Completo do Destinatário não pode ficar em branco'
    expect(page).to have_content 'Nome do Destinatário não pode ficar em branco'
    expect(page).to have_content 'Distância em km não pode ficar em branco'
  end
end

describe 'Usuário Administrador edita uma ordem de serviço' do
  it 'com sucesso' do

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'ABCDEFG12345678'
    click_on 'Editar Ordem de Serviço'

    fill_in 'Peso do Produto em kg',	with: '3'
    fill_in 'Endereço Completo do Destinatário',	with: 'Rua dos Papagaios, 60 - Curitiba PR'
    fill_in 'Distância em km',	with: '12'

    click_on 'Enviar'

    expect(page).to have_content 'Ordem de Serviço Atualizada'
    expect(page).not_to have_content 'Não foi possível atualizar Ordem de Serviço'

    expect(page).to have_content 'Ordem de Serviço - Código ABCDEFG12345678'
    expect(page).to have_content 'Endereço Completo da Saída da Carga: Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR'
    expect(page).to have_content 'Dimensões da Carga: 25cm x 17cm x 8cm'
    expect(page).to have_content 'Peso da Carga: 3kg'
    expect(page).to have_content 'Endereço Completo do Destinatário: Rua dos Papagaios, 60 - Curitiba PR'
    expect(page).to have_content 'Nome do Destinatário: Flora Mendes'
    expect(page).to have_content 'Distância que a carga vai percorrer: 12km'

  end

  it 'com dados incompletos' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFG12345678')
    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Ordem de Serviço'
    click_on 'ABCDEFG12345678'
    click_on 'Editar Ordem de Serviço'

    fill_in 'Peso do Produto em kg',	with: nil
    fill_in 'Endereço Completo do Destinatário',	with: nil
    fill_in 'Distância em km',	with: nil

    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar Ordem de Serviço'
    expect(page).not_to have_content 'Ordem de Serviço Atualizada'

    expect(page).to have_content 'Peso do Produto em kg não pode ficar em branco'
    expect(page).to have_content 'Endereço Completo do Destinatário não pode ficar em branco'
    expect(page).to have_content 'Distância em km não pode ficar em branco'
  end
end