require 'rails_helper'

describe 'Usuário Regular vê os veículos cadastrados' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(current_path).to eq carriers_path
  end

  it 'e não tem acesso ao cadastro de novos veículos' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                    minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    transp1 = TransportModel.create!(name: 'Rodoviário - Motocicleta', minimum_distance: 1, maximum_distance: 50,
                                     minimum_weight: 1, maximum_weight: 300, tax: 20)

    utili = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                            vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                            year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transp)

    moto = Carrier.create!(drivers_name: 'Roberto Siqueira', nameplate: 'FDS5A44',
                           vehicle_model: 'Triciclo Sousa Mod. TR 150', vehicle_brand: 'Sousa Motos',
                           year_of_manufacture: 2018, maximum_weight: 300, transport_model: transp1)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(page).to have_content 'Veículos Cadastrados'
    expect(page).to have_content 'Rodoviário - Utilitários'
    expect(page).to have_content 'Rodoviário - Motocicleta'
    expect(page).to have_content 'Gabriela Almeida - Renault Master 2.3 DCI Furgão L1H1 - Diesel - KLO6S98'
    expect(page).to have_content 'Roberto Siqueira - Triciclo Sousa Mod. TR 150 - FDS5A44'

    expect(page).not_to have_content 'Cadastrar Novo Veículo'
  end

  it 'e não tem acesso ao cadastro de novos veículos pela URL' do
    transport = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                       minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                    vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                    year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transport)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)
    login_as(regular)
    visit new_carrier_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui autorização para acessar essa página.'
  end

  it 'e não existem veículos cadastrados' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'

    expect(page).to have_content 'Nenhum Veículo Cadastrado.'
  end
end
