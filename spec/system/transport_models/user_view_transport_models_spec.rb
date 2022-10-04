require 'rails_helper'

# index - mode_of_transport

describe 'Usuário visita a tela de modalidades' do
  it 'e vê as modalidades de transporte' do
    TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                              minimum_weight: 1, maximum_weight: 3_000, tax: 150)

    visit root_path
    within('nav') do
    click_on 'Modalidades de Transporte'
    end

    expect(page).not_to have_content 'Nenhuma Modalidade de Transporte Cadastrada'
    expect(page).to have_content 'Modalidades de Transporte'
    expect(page).to have_content 'Cadastrar Nova Modalidade de Transporte'
    expect(page).to have_content 'Rodoviário - Caminhão'
  end

  it 'e não existem modalidades de transporte cadastradas' do
    visit root_path 
    click_on 'Modalidades de Transporte'

    expect(page).to have_content 'Cadastrar Nova Modalidade de Transporte'
    expect(page).to have_content 'Nenhuma Modalidade de Transporte Cadastrada'
  end
end
