require 'rails_helper'

describe 'Usuario Administrador tem acesso a lista de Veículos Cadastrados' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transp1)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(page).to have_content 'Veículos Cadastrados'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Fernando Mendes - Hyundai/HR 2.5 TCI 4x2 - Diesel'
  end

  it 'e tem acesso ao cadastro de um Novo Veículo' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transp1)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(page).to have_content 'Veículos Cadastrados'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Fernando Mendes - Hyundai/HR 2.5 TCI 4x2 - Diesel'
    expect(page).to have_content 'Cadastrar Novo Veículo'
  end
end

describe 'Usuario Administrador tem acesso a Edição do Veículo Cadastrado' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transp1)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Caminhão'

    expect(page).to have_content 'Editar Veículo'
  end
end
