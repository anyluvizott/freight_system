require 'rails_helper'

describe 'Usuário Administrador tem acesso a tabela de prazo de entrega' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'

    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).to have_content '100 km'
    expect(page).to have_content '48 horas'
  end
end

describe 'Usuário Administrador cadastra um novo valor à tabela de prazo de entrega' do
  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    fill_in 'Km Inicial',	with: 101
    fill_in 'Km Final',	with: 300
    fill_in 'Prazo de Entrega',	with: 96
    click_on 'Enviar'

    expect(page).to have_content 'Novo valor adicionado'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).to have_content '100 km'
    expect(page).to have_content '48 horas'
    expect(page).to have_content '101 km'
    expect(page).to have_content '300 km'
    expect(page).to have_content '96 horas'
    expect(page).to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_content 'Não foi possível adicionar novo valor'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    fill_in 'Km Inicial',	with: nil
    fill_in 'Km Final',	with: nil
    fill_in 'Prazo de Entrega',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível adicionar novo valor'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).to have_content '100 km'
    expect(page).to have_content '48 horas'
    expect(page).to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_content 'Novo valor adicionado'
  end

  it 'com valor inicial já inserido na tabela' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    fill_in 'Km Inicial',	with: 2
    fill_in 'Km Final',	with: 150
    fill_in 'Prazo de Entrega',	with: 54
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível adicionar novo valor'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).not_to have_content '5 km'
    expect(page).to have_content '100 km'
    expect(page).not_to have_content '150 km'
    expect(page).to have_content '48 horas'
    expect(page).not_to have_content '54 horas'
    expect(page).to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_content 'Novo valor adicionado'
  end

  it 'com valor final já inserido na tabela' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_deadline = DeliveryTime.create!(starting_km: 5, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    fill_in 'Km Inicial',	with: 1
    fill_in 'Km Final',	with: 50
    fill_in 'Prazo de Entrega',	with: 24
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível adicionar novo valor'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '5 km'
    expect(page).not_to have_content '1 km'
    expect(page).to have_content '100 km'
    expect(page).not_to have_content '50 km'
    expect(page).to have_content '48 horas'
    expect(page).not_to have_content '24 horas'
    expect(page).to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_content 'Novo valor adicionado'
  end
end
