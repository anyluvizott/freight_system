require 'rails_helper'

describe 'Usuário Administrador faz login' do
  it 'com sucesso' do
    User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador', status: :admin)

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail',	with: 'admin@sistemadefrete.com.br'
      fill_in 'Senha',	with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Usuário: Administrador'
  end

  it 'e faz logout' do
    User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador', status: :admin)

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail',	with: 'admin@sistemadefrete.com.br'
      fill_in 'Senha',	with: 'password'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Usuário: Administrador'
  end
end

describe 'Usuário Regular faz login' do
  it 'com sucesso' do
    User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular', status: :regular)

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail',	with: 'regular@sistemadefrete.com.br'
      fill_in 'Senha',	with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Usuário: Regular'
  end

  it 'e faz logout' do
    User.create!(email: 'regular@sistemadefrete.com.br', password: 'password', name: 'Regular', status: :regular)

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail',	with: 'regular@sistemadefrete.com.br'
      fill_in 'Senha',	with: 'password'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Usuário: Regular'
  end
end
