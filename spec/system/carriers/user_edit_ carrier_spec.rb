require 'rails_helper'

describe 'Usuário edita um veículo cadastrado' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                    minimum_weight: 1, maximum_weight: 3_000, tax: 150)
    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3_000, transport_model: transp)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Veículo'

    expect(page).to have_content 'Editar Veículo'
    expect(page).to have_field 'Nome do Motorista',	with: 'Fernando Mendes'
    expect(page).to have_field 'Placa de Identificação',	with: 'BCG5L88'
    expect(page).to have_field 'Modelo do Veículo',	with: 'Hyundai/HR 2.5 TCI 4x2 - Diesel'
    expect(page).to have_field 'Marca do Veículo',	with: 'Hyundai'
    expect(page).to have_field 'Ano de Fabricação',	with: '2016'
    expect(page).to have_field 'Peso Máximo da Carga',	with: '3000'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                    minimum_weight: 1, maximum_weight: 3_000, tax: 150)
    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3_000, transport_model: transp)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Veículo'
    fill_in 'Nome do Motorista',	with: 'Rogério Siqueira'
    fill_in 'Placa de Identificação',	with: 'GFD8K64'
    fill_in 'Peso Máximo da Carga',	with: '2500'
    click_on 'Enviar'

    expect(page).to have_content 'Veículo atualizado com sucesso.'
    expect(page).to have_content 'Nome do Motorista: Rogério Siqueira'
    expect(page).to have_content 'Placa de Identificação: GFD8K64'
    expect(page).to have_content 'Peso Máximo da Carga: 2500kg'
    expect(page).not_to have_content 'Não foi possível atualizar'
  end

  it 'e mantém os campos obrigatórios' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp = TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                                    minimum_weight: 1, maximum_weight: 3_000, tax: 150)
    truck = Carrier.create!(drivers_name: 'Fernando Mendes', nameplate: 'BCG5L88',
                            vehicle_model: 'Hyundai/HR 2.5 TCI 4x2 - Diesel', vehicle_brand: 'Hyundai',
                            year_of_manufacture: 2016, maximum_weight: 3_000, transport_model: transp)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Caminhão'
    click_on 'Editar Veículo'
    fill_in 'Nome do Motorista',	with: nil
    fill_in 'Modelo do Veículo',	with: nil
    fill_in 'Peso Máximo da Carga',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Nome do Motorista não pode ficar em branco'
    expect(page).to have_content 'Modelo do Veículo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo da Carga não pode ficar em branco'
  end
end
