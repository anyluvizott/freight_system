require 'rails_helper'

describe 'Usuário Regular tem acesso aos detalhes da Modalidade de Transporte' do
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