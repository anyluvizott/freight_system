require 'rails_helper'

describe 'Usúario cadastra um novo veículo' do
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

    transp = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                    minimum_weight: 100, maximum_weight: 2_000, tax: 50)
    transp1 = TransportModel.create!(name: 'Rodoviário - Bicicleta', minimum_distance: 1, maximum_distance: 15,
                                     minimum_weight: 1, maximum_weight: 40, tax: 10)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Cadastrar Novo Veículo'
    fill_in 'Nome do Motorista',	with: 'José Antonio'
    fill_in 'Placa de Identificação',	with: 'DFS6D44'
    fill_in 'Modelo do Veículo',	with: 'Peugeot Partner Furgão 1.6 16V - Flex'
    fill_in 'Marca do Veículo',	with: 'Peugeot'
    fill_in 'Ano de Fabricação',	with: '2016'
    fill_in 'Peso Máximo da Carga',	with: '800'
    select 'Rodoviário - Utilitários', from: 'Modelo de Transporte'
    click_on 'Enviar'

    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_content 'Rodoviário - Utilitários'
    expect(page).to have_content 'Nome do Motorista: José Antonio'
    expect(page).to have_content 'Placa de Identificação: DFS6D44'
    expect(page).to have_content 'Modelo do Veículo: Peugeot Partner Furgão 1.6 16V - Flex'
    expect(page).to have_content 'Marca do Veículo: Peugeot'
    expect(page).to have_content 'Ano de Fabricação: 2016'
    expect(page).to have_content 'Peso Máximo da Carga: 800kg'
    expect(page).not_to have_content 'Rodoviário - Bicicleta'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

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

    expect(page).to have_content 'Veículo não cadastrado.'
    expect(page).to have_content 'Nome do Motorista não pode ficar em branco'
    expect(page).to have_content 'Modelo do Veículo não pode ficar em branco'
    expect(page).to have_content 'Marca do Veículo não pode ficar em branco'
    expect(page).to have_content 'Ano de Fabricação não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo da Carga não pode ficar em branco'
    expect(page).not_to have_content 'Veículo cadastrado com sucesso.'
  end
end
