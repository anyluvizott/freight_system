require 'rails_helper'

describe 'Usuário Administrador visualiza os tipos de modalidades de entrega' do
  it 'a partir da página inicial' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transport = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                       minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 48,
                                   transport_model: transport)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'

    expect(page).to have_content 'Rodoviário - Bicicleta'
    expect(page).to have_content 'Tipo de Modalidade'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content '1 km'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content '15 km'
    expect(page).to have_content 'Tempo de Entrega'
    expect(page).to have_content '48 horas'
    expect(page).to have_link 'Editar'
  end

  it 'e não vê tipos de modalidades de entrega de outras modalidades de transporte' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)
    motorcycle = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 10, maximum_distance: 200,
                                        minimum_weight: 1, maximum_weight: 300, tax: 20)

    bicycle = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    model_type_two = ModelType.create!(name: 'Entrega Expressa', starting_km: 10, final_km: 200, deadline: 24,
                                       transport_model: motorcycle)

    model_type_one = ModelType.create!(name: 'Entrega Comum', starting_km: 1, final_km: 15, deadline: 48,
                                       transport_model: bicycle)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Bicicleta'

    expect(page).to have_content 'Rodoviário - Bicicleta'
    expect(page).to have_content 'Tipo de Modalidade'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content '1 km'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content '15 km'
    expect(page).to have_content 'Tempo de Entrega'
    expect(page).to have_content '48 horas'
    expect(page).not_to have_content 'Rodoviário - Motocicleta'
    expect(page).not_to have_content 'Entrega Expressa'
    expect(page).not_to have_content '10 km'
    expect(page).not_to have_content '200 km'
    expect(page).not_to have_content '24 horas'
  end
end

describe 'Usuário Administrador cadastra um novo tipo de modalidade de entrega' do
  it 'a partir da página inicial' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    car = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                 minimum_weight: 50, maximum_weight: 2000, tax: 50)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Utilitários'
    click_on 'Cadastrar Novo Tipo de Modalidade de Entrega'

    expect(current_path).to eq new_model_type_path
    expect(page).to have_content 'Cadastrar Novo Tipo de Modalidade de Entrega'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Distância Inicial'
    expect(page).to have_field 'Distância Final'
    expect(page).to have_field 'Tempo de Entrega'
    expect(page).to have_field 'Modalidade de Transporte'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    car = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                 minimum_weight: 50, maximum_weight: 2000, tax: 50)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Utilitários'
    click_on 'Cadastrar Novo Tipo de Modalidade de Entrega'
    fill_in 'Nome',	with: 'Entrega Comum'
    fill_in 'Distância Inicial',	with: '20'
    fill_in 'Distância Final',	with: '500'
    fill_in 'Tempo de Entrega',	with: '48'
    select 'Rodoviário - Utilitários', from: 'Modalidade de Transporte'
    click_on 'Enviar'

    expect(current_path).to eq model_type_path(1)
    expect(page).to have_content 'Novo Tipo de Modalidade de Entrega cadastrada com sucesso'
    expect(page).to have_content 'Modalidade de Entrega'
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_content 'Tipo de Entrega'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content 'Tempo de Entrega'
    expect(page).to have_content 'Rodoviário - Utilitários'
    expect(page).to have_content 'Entrega Comum'
    expect(page).to have_content '20 km'
    expect(page).to have_content '500 km'
    expect(page).to have_content '48 horas'
    expect(page).to have_link 'Editar'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    car = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                 minimum_weight: 50, maximum_weight: 2000, tax: 50)

    login_as(admin)
    visit root_path
    click_on 'Modalidades de Transporte'
    click_on 'Rodoviário - Utilitários'
    click_on 'Cadastrar Novo Tipo de Modalidade de Entrega'
    fill_in 'Nome',	with: nil
    fill_in 'Distância Inicial',	with: nil
    fill_in 'Distância Final',	with: nil
    fill_in 'Tempo de Entrega',	with: nil
    click_on 'Enviar'

    expect(current_path).to eq model_types_path
    expect(page).to have_content 'Não foi possível adicionar o Tipo de Modalidade de Entrega'
    expect(page).not_to have_content 'Novo Tipo de Modalidade de Entrega cadastrada com sucesso'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância Inicial não pode ficar em branco'
    expect(page).to have_content 'Distância Final não pode ficar em branco'
    expect(page).to have_content 'Tempo de Entrega não pode ficar em branco'
  end
end
