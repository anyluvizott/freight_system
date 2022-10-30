require 'rails_helper'

describe 'Usuário Regular visualiza as modalidades de entrega' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    bicycle = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 32,
                                   transport_model: bicycle)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'

    expect(page).to have_content 'Modalidades de Entregas'
    expect(page).to have_content 'Tipo de Modalidade'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content '1 km'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content '15 km'
    expect(page).to have_content 'Tempo de Entrega'
    expect(page).to have_content '32 horas'
  end

  it 'e não tem acesso a adição e ao cadastro de um novo do tipo de entrega' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    bicycle = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 32,
                                   transport_model: bicycle)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'

    expect(page).to have_content 'Modalidades de Entregas'
    expect(page).to have_content 'Tipo de Modalidade'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content '1 km'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content '15 km'
    expect(page).to have_content 'Tempo de Entrega'
    expect(page).to have_content '32 horas'
    expect(page).not_to have_content 'Editar Tipo de Entrega'
    expect(page).not_to have_content 'Cadastrar Novo Tipo de Modalidade de Entrega'
  end
end
