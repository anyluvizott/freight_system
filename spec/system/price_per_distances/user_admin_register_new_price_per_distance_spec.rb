require 'rails_helper'

describe 'Usuário Administrador tem acesso a tabela de preço por distância' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    login_as(admin)
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
end

describe 'Usuário Administrador cadastra um novo valor à tabela de preço por distância' do
  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    fill_in 'Distância Inicial',	with: 1
    fill_in 'Distância Final',	with: 50
    fill_in 'Preço Fixo',	with: 9
    click_on 'Enviar'

    expect(page).to have_content 'Novo valor adicionado'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content 'Preço Fixo'
    expect(page).to have_content '1 km'
    expect(page).to have_content '50 km'
    expect(page).to have_content 'R$ 9,00'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    fill_in 'Distância Inicial',	with: nil
    fill_in 'Distância Final',	with: nil
    fill_in 'Preço Fixo',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível adicionar novo valor, os campos não podem ficar em branco'
    expect(page).not_to have_content 'Novo valor adicionado'
  end
end
