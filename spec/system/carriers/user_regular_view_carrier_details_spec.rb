require 'rails_helper'

describe 'Usuário Regular vê detalhes dos veículos cadastrados' do
  it 'a partir da tela inicial' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                    minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    utili = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                            vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                            year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transp)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Utilitários'

    expect(page).to have_content 'Rodoviário - Utilitários'
    expect(page).to have_content 'Nome do Motorista: Gabriela Almeida'
    expect(page).to have_content 'Placa de Identificação: KLO6S98'
    expect(page).to have_content 'Modelo do Veículo: Renault Master 2.3 DCI Furgão L1H1 - Diesel'
    expect(page).to have_content 'Marca do Veículo: Renault'
    expect(page).to have_content 'Ano de Fabricação: 2019'
    expect(page).to have_content 'Peso Máximo da Carga: 1500kg'
    expect(page).to have_link 'Voltar'
  end

  it 'e não tem acesso a edição do veiculo cadastrado' do
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

  it 'e volta para a tela inicial' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    transp = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                    minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    utili = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                            vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                            year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transp)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Utilitários'
    click_on 'Voltar'

    expect(current_path).to eq carriers_path
  end
end
