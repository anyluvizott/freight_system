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
