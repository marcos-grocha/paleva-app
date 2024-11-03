require 'rails_helper'

describe 'Usuário cadastra um prato' do
  it 'com sucesso' do
    user_owner = create_user()
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
  end

  it 'com sucesso e vê detalhes' do
    user_owner = create_user()
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
    expect(page).to have_css("img[src*='feijoada.jpg']")
  end
end
