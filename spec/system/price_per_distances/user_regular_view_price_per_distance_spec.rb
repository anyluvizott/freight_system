require 'rails_helper'

describe 'Usuário Regular tem acesso a tabela de preços por distância' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Preço por Distância'

    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content 'Preço Fixo'
    expect(page).to have_content '1 km'
    expect(page).to have_content '50 km'
    expect(page).to have_content 'R$ 9,00'
  end

  it 'e não tem acesso ao cadastro de novos valores' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Preço por Distância'

    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content 'Preço Fixo'
    expect(page).to have_content '1 km'
    expect(page).to have_content '50 km'
    expect(page).to have_content 'R$ 9,00'

    expect(page).not_to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_button 'Enviar'
  end

  it 'e não tem acesso a edição dos valores cadastrados' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Preço por Distância'

    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content 'Preço Fixo'
    expect(page).to have_content '1 km'
    expect(page).to have_content '50 km'
    expect(page).to have_content 'R$ 9,00'

    expect(page).not_to have_link 'Editar'
  end

  it 'e não tem acesso edição dos valores cadastrados pela URL' do
    price_per_distance = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit edit_price_per_distance_path(price_per_distance.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui autorização para acessar essa página.'
  end
end
