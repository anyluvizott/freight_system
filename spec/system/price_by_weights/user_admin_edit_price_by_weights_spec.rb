require 'rails_helper'

describe 'Usuário Administrador edita um valor da tabela de preço por peso' do
  it 'a partir do menu' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Peso'
    click_on 'Editar'

    expect(page).to have_content 'Editar valor da Tabela de Preço por Peso'
    expect(page).to have_field 'Peso Inicial', with: 1
    expect(page).to have_field 'Peso Final', with: 10
    expect(page).to have_field 'Preço por Km', with: 0.5
  end

  it 'com sucesso' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Peso'
    click_on 'Editar'
    fill_in 'Peso Final',	with: 20
    fill_in 'Preço por Km',	with: 0.82
    click_on 'Enviar'

    expect(page).to have_content 'Valor atualizado com sucesso'
    expect(page).not_to have_content 'Não foi possível atualizar'
    expect(page).to have_content 'Peso Inicial'
    expect(page).to have_content 'Peso Final'
    expect(page).to have_content 'Valor por KM'
    expect(page).to have_content '1 kg'
    expect(page).to have_content '20 kg'
    expect(page).to have_content 'R$ 0,82'
  end

  it 'com dados incompletos' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    first_line = PriceByWeight.create!(starting_weight: 1, final_weight: 10, price_per_km: 0.50)

    login_as(admin)
    visit root_path
    click_on 'Tabela de Preço por Peso'
    click_on 'Editar'
    fill_in 'Peso Final',	with: nil
    fill_in 'Preço por Km',	with: nil
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar'
    expect(page).not_to have_content 'Valor atualizado com sucesso'
    expect(page).to have_content 'Peso Final não pode ficar em branco'
    expect(page).to have_content 'Preço por Km não pode ficar em branco'
  end
end
