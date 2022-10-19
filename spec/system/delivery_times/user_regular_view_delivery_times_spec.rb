require 'rails_helper'

describe 'Usuário Regular tem acesso a tabela de prazos de entrega' do
  it 'a partir do menu' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(regular)
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

  it 'e não tem acesso ao cadastro de novos valores' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'

    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).to have_content '100 km'
    expect(page).to have_content '48 horas'

    expect(page).not_to have_content 'Adicionar Novos Valores à Tabela'
    expect(page).not_to have_button 'Enviar'
  end

  it 'e não tem acesso a edição dos valores cadastrados' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    first_deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    login_as(regular)
    visit root_path
    click_on 'Tabela de Prazo de Entrega'

    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content 'Km Inicial'
    expect(page).to have_content 'Km Final'
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content '1 km'
    expect(page).to have_content '100 km'
    expect(page).to have_content '48 horas'

    expect(page).not_to have_link 'Editar'
  end

  it 'e não tem acesso a edição dos valores cadastrados pela URL' do
    deadline = DeliveryTime.create!(starting_km: 1, final_km: 100, deadline: 48)

    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular',
                           status: :regular)

    login_as(regular)
    visit edit_delivery_time_path(deadline.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui autorização para acessar essa página.'
  end
end
