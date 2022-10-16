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

    line_one = PricePerDistance.create!(starting_km: 1, final_km: 50, fixed_price: 9)

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
end
