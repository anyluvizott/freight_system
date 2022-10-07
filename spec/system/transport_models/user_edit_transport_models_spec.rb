require 'rails_helper'

describe 'Usuário edita uma modalidade de transporte' do
  it 'a partir da página de detalhes' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                           minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Modalidade'

    expect(page).to have_content 'Editar Modalidade de Transporte'
    expect(page).to have_field 'Nome da Modalidade',	with: 'Rodoviário - Caminhão'
    expect(page).to have_field 'Distância Mínima',	with: '1'
    expect(page).to have_field 'Distância Máxima',	with: '600'
    expect(page).to have_field 'Peso Mínimo da Carga',	with: '1'
    expect(page).to have_field 'Peso Máximo da Carga',	with: '3000'
    expect(page).to have_field 'Taxa Fixa de Entrega',	with: '150'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                           minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Modalidade'
    fill_in 'Distância Máxima',	with: '650'
    fill_in 'Peso Máximo da Carga',	with: '3500'
    click_on 'Enviar'

    expect(page).to have_content 'Modalidade Atualizada com Sucesso'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Distância Mínima Percorrida: 1km'
    expect(page).to have_content 'Distância Máxima Percorrida: 650km'
    expect(page).to have_content 'Peso Mínimo da Carga: 1kg'
    expect(page).to have_content 'Peso Máximo da Carga: 3500kg'
    expect(page).to have_content 'Taxa Fixa de Entrega: R$ 150,00'
  end

  it 'e mantém os campos obrigatórios' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                           minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Modalidade'
    fill_in 'Distância Máxima',	with: nil
    fill_in 'Peso Máximo da Carga',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo da Carga não pode ficar em branco'
  end
end
