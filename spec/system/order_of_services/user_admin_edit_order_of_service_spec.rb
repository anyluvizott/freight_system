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
    fill_in 'Peso do Produto em kg',	with: 3
    fill_in 'Endereço Completo do Destinatário',	with: 'Rua dos Papagaios, 60 - Curitiba PR'
    fill_in 'Distância em km',	with: 12
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
