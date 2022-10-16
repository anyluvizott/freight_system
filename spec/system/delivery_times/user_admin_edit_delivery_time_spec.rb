require 'rails_helper'

describe 'Usuário Administrador edita um valor da tabela de prazo de entrega' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)
    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'

    expect(page).to have_content 'Editar valor da Tabela de Prazo de Entrega'
    expect(page).to have_field 'Km Inicial', with: 1
    expect(page).to have_field 'Km Final', with: 100
    expect(page).to have_field 'Prazo de Entrega', with: 48
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)
    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'
    fill_in 'Km Final',	with: 150
    fill_in 'Prazo de Entrega',	with: 52
    click_on 'Enviar'

    expect(page).to have_content 'Valor atualizado com sucesso'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).to have_content '150 km'
    expect(page).to have_content '52 horas'
    expect(page).not_to have_content 'Não foi possível atualizar'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)
    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'
    fill_in 'Km Final',	with: nil
    fill_in 'Prazo de Entrega',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Km Final não pode ficar em branco'
    expect(page).to have_content 'Prazo de Entrega não pode ficar em branco'
    expect(page).not_to have_content 'Valor atualizado com sucesso'
  end
end
