require 'rails_helper'

describe 'Usuário Administrador edita o Tipo de Modalidade de Entrega' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    truck = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 100, maximum_distance: 1000,
                                   minimum_weight: 1000, maximum_weight: 3000, tax: 150)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 100, final_km: 1000, deadline: 48,
                                   transport_model: truck)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Tipo de Entrega'

    expect(page).to have_content 'Forma de Entrega da Modalidade de Transporte Rodoviário - Caminhão'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Distância Inicial'
    expect(page).to have_field 'Distância Final'
    expect(page).to have_field 'Tempo de Entrega'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    truck = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 100, maximum_distance: 1000,
                                   minimum_weight: 1000, maximum_weight: 3000, tax: 150)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 100, final_km: 1000, deadline: 48,
                                   transport_model: truck)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Tipo de Entrega'
    fill_in 'Distância Final',	with: 500
    fill_in 'Tempo de Entrega',	with: 32
    click_on 'Enviar'

    expect(page).to have_content 'Tipo de Modelo de Entrega atualizado com sucesso'
    expect(page).to have_content 'Modalidade de Entrega'
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Tipo de Entrega'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content '100 km'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content '500 km'
    expect(page).not_to have_content '1000 km'
    expect(page).to have_content 'Tempo de Entrega'
    expect(page).to have_content '32 horas'
    expect(page).not_to have_content '48 horas'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    truck = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 100, maximum_distance: 1000,
                                   minimum_weight: 1000, maximum_weight: 3000, tax: 150)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 100, final_km: 1000, deadline: 48,
                                   transport_model: truck)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Tipo de Entrega'
    fill_in 'Nome',	with: nil
    fill_in 'Distância Inicial',	with: nil
    fill_in 'Distância Final',	with: nil
    fill_in 'Tempo de Entrega',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).not_to have_content 'Tipo de Modelo de Entrega atualizado com sucesso'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância Inicial não pode ficar em branco'
    expect(page).to have_content 'Distância Final não pode ficar em branco'
    expect(page).to have_content 'Tempo de Entrega não pode ficar em branco'
  end
end
