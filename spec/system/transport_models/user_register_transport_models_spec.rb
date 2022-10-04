require 'rails_helper'

describe 'Usúario cadastra uma nova modalidade de transporte' do
  it 'a partir do menu' do

    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Cadastrar Nova Modalidade de Transporte'

    expect(page).to have_field 'Nome da Modalidade'
    expect(page).to have_field 'Distância Mínima'
    expect(page).to have_field 'Distância Máxima'
    expect(page).to have_field 'Peso Mínimo da Carga'
    expect(page).to have_field 'Peso Máximo da Carga'
    expect(page).to have_field 'Taxa Fixa de Entrega'
  end

  it 'com sucesso' do

    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Cadastrar Nova Modalidade de Transporte'
    fill_in 'Nome da Modalidade',	with: 'Rodoviário - Caminhão'
    fill_in 'Distância Mínima',	with: '1'
    fill_in 'Distância Máxima',	with: '600'
    fill_in 'Peso Mínimo da Carga',	with: '1'
    fill_in 'Peso Máximo da Carga',	with: '3000'
    fill_in 'Taxa Fixa de Entrega',	with: '150'
    click_on 'Enviar'

    expect(page).to have_content 'Modalidade de Transporte cadastrada com sucesso'
    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Distância Mínima Percorrida: 1km'
    expect(page).to have_content 'Distância Máxima Percorrida: 600km'
    expect(page).to have_content 'Peso Mínimo da Carga: 1kg'
    expect(page).to have_content 'Peso Máximo da Carga: 3000kg'
    expect(page).to have_content 'Taxa Fixa de Entrega: R$ 150,00'
  end

  it 'com dados incompletos' do

    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Cadastrar Nova Modalidade de Transporte'
    fill_in 'Nome da Modalidade',	with: ''
    fill_in 'Distância Mínima',	with: ''
    fill_in 'Distância Máxima',	with: ''
    fill_in 'Peso Mínimo da Carga',	with: ''
    fill_in 'Peso Máximo da Carga',	with: ''
    fill_in 'Taxa Fixa de Entrega',	with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Modalidade de Transporte não cadastrada'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Peso Mínimo da Carga não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo da Carga não pode ficar em branco'
    expect(page).to have_content 'Taxa Fixa de Entrega não pode ficar em branco'
  end
end
