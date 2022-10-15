require 'rails_helper'

describe 'Usuário Administrador cadastra um novo veículo' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Cadastrar Novo Veículo'

    expect(page).to have_content 'Cadastrar Novo Veículo'
    expect(page).to have_field 'Nome do Motorista'
    expect(page).to have_field 'Placa de Identificação'
    expect(page).to have_field 'Modelo do Veículo'
    expect(page).to have_field 'Marca do Veículo'
    expect(page).to have_field 'Ano de Fabricação'
    expect(page).to have_field 'Peso Máximo da Carga'
    expect(page).to have_field 'Modelo de Transporte'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transport_one = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                           minimum_weight: 50, maximum_weight: 2000, tax: 50)

    transport_two = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                           minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Cadastrar Novo Veículo'
    fill_in 'Nome do Motorista',	with: 'José Miranda '
    fill_in 'Placa de Identificação',	with: 'ACG5L82'
    fill_in 'Modelo do Veículo',	with: 'Hyundai/HR 2.5 TCI 4x2 - Diesel'
    fill_in 'Marca do Veículo',	with: 'Hyundai'
    fill_in 'Ano de Fabricação',	with: 2016
    fill_in 'Peso Máximo da Carga',	with: 3000
    select 'Rodoviário - Caminhão', from: 'Modelo de Transporte'
    click_on 'Enviar'

    expect(page).to have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Nome do Motorista: José Miranda'
    expect(page).to have_content 'Placa de Identificação: ACG5L82'
    expect(page).to have_content 'Modelo do Veículo: Hyundai/HR 2.5 TCI 4x2 - Diesel'
    expect(page).to have_content 'Marca do Veículo: Hyundai'
    expect(page).to have_content 'Ano de Fabricação: 2016'
    expect(page).to have_content 'Peso Máximo da Carga: 3000kg'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Ativo'

    expect(page).not_to have_content 'Veículo não cadastrado'
    expect(page).to have_link 'Voltar'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transport_one = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                           minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Cadastrar Novo Veículo'
    fill_in 'Nome do Motorista',	with: nil
    fill_in 'Placa de Identificação',	with: nil
    fill_in 'Modelo do Veículo',	with: nil
    fill_in 'Marca do Veículo',	with: nil
    fill_in 'Ano de Fabricação',	with: nil
    fill_in 'Peso Máximo da Carga',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Veículo não cadastrado'
    expect(page).to have_content 'Nome do Motorista não pode ficar em branco'
    expect(page).to have_content 'Placa de Identificação não pode ficar em branco'
    expect(page).to have_content 'Modelo do Veículo não pode ficar em branco'
    expect(page).to have_content 'Marca do Veículo não pode ficar em branco'
    expect(page).to have_content 'Ano de Fabricação não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo da Carga não pode ficar em branco'

    expect(page).not_to have_content 'Veículo cadastrado com sucesso'
  end
end
