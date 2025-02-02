require 'rails_helper'

describe 'Usuário cadastra um prato' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    create_establishment(user_owner)

    visit new_dish_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    create_establishment(user_owner)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto com carne'
    fill_in 'Calorias', with: ''
    attach_file 'Foto do Prato', Rails.root.join('spec', 'support', 'feijoada.jpg')
    click_on 'Salvar'

    expect(page).to have_content 'Prato cadastrado com sucesso!'
    expect(page).to have_content 'Pratos Disponíveis'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Ativado'
  end

  it 'com sucesso e vê detalhes' do
    user_owner = create_user_owner()
    create_establishment(user_owner)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto com carne'
    fill_in 'Calorias', with: ''
    attach_file 'Foto do Prato', Rails.root.join('spec', 'support', 'feijoada.jpg')
    click_on 'Salvar'
    click_on 'Feijoada'

    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijão preto com carne'
    expect(page).to have_css("img[src*='feijoada.jpg']")
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()
    create_establishment(user_owner)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Falha ao cadastrar prato'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).not_to have_content 'Prato cadastrado com sucesso!'
  end
end
