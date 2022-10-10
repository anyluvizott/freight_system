require 'rails_helper'

describe 'Usuario Regular tem acesso a lista de Modalidades de Transporte' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    transp2 = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 500,
                                     minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'

    expect(page).to have_content 'Modalidades de Transporte'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Rodoviário - Utilitários'
  end

  it 'e não tem acesso ao cadastro de Modalidades de Tranporte' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    transp2 = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 500,
                                     minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'

    expect(page).to have_content 'Usuário: Regular'
    expect(page).to have_content 'Modalidades de Transporte'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Rodoviário - Utilitários'
    expect(page).not_to have_content 'Cadastrar Nova Modalidade de Transporte'
  end
end

describe 'Usuario Regular tem acesso aos detalhes da Modalidade de Transporte' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Caminhão'

    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Distância Mínima Percorrida: 1km'
    expect(page).to have_content 'Distância Máxima Percorrida: 1000km'
    expect(page).to have_content 'Peso Mínimo da Carga: 1kg'
    expect(page).to have_content 'Peso Máximo da Carga: 3000kg'
    expect(page).to have_content 'Taxa Fixa de Entrega: R$ 150,00'
    expect(page).to have_link 'Voltar'
  end

  it 'e não tem acesso a edição dos detalhes da Modalidade de Tranporte' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Caminhão'

    expect(page).not_to have_content 'Editar Modalidade'
  end
end
