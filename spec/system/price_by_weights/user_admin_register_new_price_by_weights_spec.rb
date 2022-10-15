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

describe 'Usuário Administrador cadastra um novo valor à tabela' do
  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Peso'
    fill_in 'Peso Inicial',	with: 11
    fill_in 'Peso Final',	with: 50
    fill_in 'Preço por Km',	with: 0.80
    click_on 'Enviar'

    expect(page).to have_content 'Novo valor adicionado'
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content 'Peso Inicial'
    expect(page).to have_content 'Peso Final'
    expect(page).to have_content 'Valor por KM'
    expect(page).to have_content '1 kg'
    expect(page).to have_content '10 kg'
    expect(page).to have_content 'R$ 0,50'
    expect(page).to have_content '11 kg'
    expect(page).to have_content '50 kg'
    expect(page).to have_content 'R$ 0,80'
    expect(page).to have_content 'Adicionar Novos Valores à Tabela'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Peso'
    fill_in 'Peso Inicial',	with: nil
    fill_in 'Peso Final',	with: nil
    fill_in 'Preço por Km',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível adicionar novo valor, os campos não podem ficar em branco'
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content 'Peso Inicial'
    expect(page).to have_content 'Peso Final'
    expect(page).to have_content 'Valor por KM'
    expect(page).to have_content '1 kg'
    expect(page).to have_content '10 kg'
    expect(page).to have_content 'R$ 0,50'
    expect(page).to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_content 'Novo valor adicionado'
  end
end
