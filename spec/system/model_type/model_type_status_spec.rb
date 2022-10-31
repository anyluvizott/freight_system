require 'rails_helper'

describe 'Usuário administrador altera o status da Modalidade de Entrega' do
  it 'para inativo, a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    bicycle = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 24,
                                   transport_model: bicycle)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'
    click_on 'Inativar'

    expect(page).to have_content 'Status'
    expect(page).to have_content 'Inativo'
    expect(page).to have_button 'Ativar'
    expect(page).not_to have_button 'Inativar'
  end

  it 'para ativo' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    bicycle = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 24,
                                   transport_model: bicycle, status: :inactive)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'
    click_on 'Ativar'

    expect(page).to have_content 'Status'
    expect(page).to have_content 'Ativo'
    expect(page).to have_button 'Inativar'
    expect(page).not_to have_button 'Ativar'
  end
end

describe 'Usuário Regular não tem acesso a alteração do status da Modalidade de Entrega' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    bicycle = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 24,
                                   transport_model: bicycle)

    login_as(regular)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'

    expect(page).not_to have_button 'Ativar'
    expect(page).not_to have_button 'Inativar'
  end
end
