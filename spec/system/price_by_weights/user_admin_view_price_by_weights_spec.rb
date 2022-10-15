require 'rails_helper'

describe 'Usuário Administrador tem acesso a tabela de preços' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Peso'

    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content 'Peso Inicial'
    expect(page).to have_content 'Peso Final'
    expect(page).to have_content 'Valor por KM'
    expect(page).to have_content '1 kg'
    expect(page).to have_content '10 kg'
    expect(page).to have_content 'R$ 0,50'
  end
end
