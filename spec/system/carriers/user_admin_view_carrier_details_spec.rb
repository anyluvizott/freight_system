require 'rails_helper'

describe 'Usuário Administrador vê detalhes dos veículos cadastrados' do
  it 'a partir da tela inicial' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                    minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    utili = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                            vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                            year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transp)

    login_as(admin)
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

  it 'e volta para a tela inicial' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transp = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 1, maximum_distance: 150,
                                    minimum_weight: 100, maximum_weight: 2_000, tax: 50)

    utili = Carrier.create!(drivers_name: 'Gabriela Almeida', nameplate: 'KLO6S98',
                            vehicle_model: 'Renault Master 2.3 DCI Furgão L1H1 - Diesel', vehicle_brand: 'Renault',
                            year_of_manufacture: 2019, maximum_weight: 1_500, transport_model: transp)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Utilitários'
    click_on 'Voltar'

    expect(current_path).to eq carriers_path
  end
end
