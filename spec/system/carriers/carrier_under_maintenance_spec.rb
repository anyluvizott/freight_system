require 'rails_helper'

describe 'Usuário Administrador pode mudar o status de um veículo para em manutenção' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transport_two = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                           minimum_weight: 50, maximum_weight: 2000, tax: 50)

    utility_one = Carrier.create!(drivers_name: 'José Antonio', nameplate: 'DFS6D44',
                                  vehicle_model: 'Peugeot Partner Furgão 1.6 16V - Flex', vehicle_brand: 'Peugeot',
                                  year_of_manufacture: 2016, maximum_weight: 800, transport_model: transport_two)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Utilitários'
    click_on 'Veículo em Manutenção'

    expect(page).to have_content 'Status: Em Manutenção'
    expect(page).to have_button 'Veículo Ativo'
    expect(page).not_to have_button 'Veículo em Manutenção'
  end

  it 'e coloca o veículo ativo novamente' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    transport_two = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                           minimum_weight: 50, maximum_weight: 2000, tax: 50)

    utility_one = Carrier.create!(drivers_name: 'José Antonio', nameplate: 'DFS6D44',
                                  vehicle_model: 'Peugeot Partner Furgão 1.6 16V - Flex', vehicle_brand: 'Peugeot',
                                  year_of_manufacture: 2016, maximum_weight: 800, transport_model: transport_two)

    login_as(admin)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Utilitários'
    click_on 'Veículo em Manutenção'
    click_on 'Veículo Ativo'

    expect(page).to have_content 'Status: Ativo'
    expect(page).to have_button 'Veículo em Manutenção'
    expect(page).not_to have_button 'Veículo Ativo'
  end
end

describe 'Usuário Regular não tem acesso a edição do status do veículo' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)
    transport_two = TransportModel.create!(name: 'Rodoviário - Utilitários', minimum_distance: 20, maximum_distance: 500,
                                           minimum_weight: 50, maximum_weight: 2000, tax: 50)

    utility_one = Carrier.create!(drivers_name: 'José Antonio', nameplate: 'DFS6D44',
                                  vehicle_model: 'Peugeot Partner Furgão 1.6 16V - Flex', vehicle_brand: 'Peugeot',
                                  year_of_manufacture: 2016, maximum_weight: 800, transport_model: transport_two)

    login_as(regular)
    visit root_path
    click_on 'Veículos Cadastrados'
    click_on 'Rodoviário - Utilitários'

    expect(page).not_to have_button 'Veículo em Manutenção'
  end
end
