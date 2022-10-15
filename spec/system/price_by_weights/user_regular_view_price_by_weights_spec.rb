require 'rails_helper'

describe 'Usuário Regular tem acesso a tabela de preços' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(regular)
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

  it 'e não tem acesso ao cadastro de novos valores' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Preço por Peso'

    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content 'Peso Inicial'
    expect(page).to have_content 'Peso Final'
    expect(page).to have_content 'Valor por KM'
    expect(page).to have_content '1 kg'
    expect(page).to have_content '10 kg'
    expect(page).to have_content 'R$ 0,50'

    expect(page).not_to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_link 'Enviar'
  end

  it 'e não tem acesso a edição dos valores cadastrados' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Preço por Peso'

    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content 'Peso Inicial'
    expect(page).to have_content 'Peso Final'
    expect(page).to have_content 'Valor por KM'
    expect(page).to have_content '1 kg'
    expect(page).to have_content '10 kg'
    expect(page).to have_content 'R$ 0,50'

    expect(page).not_to have_content 'Editar'
  end
end
