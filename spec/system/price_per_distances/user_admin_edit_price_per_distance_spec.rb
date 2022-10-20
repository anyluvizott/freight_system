require 'rails_helper'

describe 'Usuário Administrador edita um valor da tabela de preço por distância' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'

    expect(page).to have_content 'Editar valor da Tabela de Preço por Distância'
    expect(page).to have_field 'Distância Inicial', with: 1
    expect(page).to have_field 'Distância Final', with: 50
    expect(page).to have_field 'Preço Fixo', with: 9.0
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    line_one = PricePerDistance.create!(starting_km: 5, final_km: 50, fixed_price: 9)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
    fill_in 'Distância Inicial',	with: 2
    fill_in 'Preço Fixo',	with: 10.0
    click_on 'Enviar'

    expect(page).to have_content 'Valor atualizado com sucesso'
    expect(page).to have_content 'Distância Inicial'
    expect(page).to have_content 'Distância Final'
    expect(page).to have_content 'Preço Fixo'
    expect(page).to have_content '2 km'
    expect(page).to have_content '50 km'
    expect(page).to have_content 'R$ 10,00'
    expect(page).not_to have_content 'Não foi possível atualizar'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
    fill_in 'Distância Inicial',	with: nil
    fill_in 'Preço Fixo',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Distância Inicial não pode ficar em branco'
    expect(page).to have_content 'Preço Fixo não pode ficar em branco'
    expect(page).not_to have_content 'Valor atualizado com sucesso'
  end

  it 'com valor inicial já inserido na tabela' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)
    line_two = PricePerDistance.create!(starting_km: 51, final_km: 150, fixed_price: 12)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    first(:link, 'Editar').click
    fill_in 'Distância Inicial',	with: 55
    fill_in 'Distância Final',	with: 200
    fill_in 'Preço Fixo',	with: 20
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Distância Inicial não pode já estar incluido na tabela'
    expect(page).not_to have_content 'Valor atualizado com sucesso'
    expect(page).not_to have_content '55 km'
    expect(page).not_to have_content '200 km'
    expect(page).not_to have_content 'R$ 20,00'
  end

  it 'com valor final já inserido na tabela' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    line_one = PricePerDistance.create!(starting_km: 20, final_km: 50, fixed_price: 9)
    line_two = PricePerDistance.create!(starting_km: 51, final_km: 150, fixed_price: 12)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Distância'
    first(:link, 'Editar').click
    fill_in 'Distância Inicial',	with: 1
    fill_in 'Distância Final',	with: 30
    fill_in 'Preço Fixo',	with: 5
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Distância Final não pode já estar incluido na tabela'
    expect(page).not_to have_content 'Valor atualizado com sucesso'
    expect(page).not_to have_content '1 km'
    expect(page).not_to have_content '30 km'
    expect(page).not_to have_content 'R$ 5,00'
  end
end
