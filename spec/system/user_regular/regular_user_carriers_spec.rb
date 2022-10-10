require 'rails_helper'

describe 'Usuario Regular tem acesso a lista de Veículos Cadastrados' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transp1)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(page).to have_content 'Veículos Cadastrados'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Fernando Mendes - Hyundai/HR 2.5 TCI 4x2 - Diesel'
  end

  it 'e não tem acesso ao cadastro de um Novo Veículo' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transp1)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(page).to have_content 'Veículos Cadastrados'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Fernando Mendes - Hyundai/HR 2.5 TCI 4x2 - Diesel'
    expect(page).not_to have_content 'Cadastrar Novo Veículo'
  end
end

describe 'Usuario Regular não tem acesso a Edição do Veículo Cadastrado' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp1 = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 1000,
                                     minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3000, transport_model: transp1)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Caminhão'

    expect(page).not_to have_content 'Editar Veículo'
  end
end
