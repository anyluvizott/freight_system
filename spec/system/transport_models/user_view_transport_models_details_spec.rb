require 'rails_helper'

describe 'Usuário vê detalhes das modalidades de transporte' do
  it 'a partir da tela inicial' do
    TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                           minimum_weight: 1, maximum_weight: 3_000)

    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Rodoviário - Caminhão'

    expect(page).to have_content 'Rodoviário - Caminhão'
    expect(page).to have_content 'Distância Mínima Percorrida: 1km'
    expect(page).to have_content 'Distância Máxima Percorrida: 600km'
    expect(page).to have_content 'Peso Mínimo da Carga: 1kg'
    expect(page).to have_content 'Peso Máximo da Carga: 3000kg'
  end

  it 'e volta para a tela inicial' do
    TransportModel.create!(name: 'Rodoviário - Caminhão', minimum_distance: 1, maximum_distance: 600,
                           minimum_weight: 1, maximum_weight: 3_000)

    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Rodoviário - Caminhão'
    click_on 'Voltar'

    expect(current_path).to eq transport_models_path
  end
end
