require 'rails_helper'

describe 'Usuário cadastra uma bebida' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    visit new_beverage_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'sem alcool com sucesso' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Coca-Cola'
    fill_in 'Descrição', with: 'Refrigerante de Cola'
    fill_in 'Calorias', with: ''
    attach_file 'Foto da Bebida', Rails.root.join('spec', 'support', 'coca-cola.jpg')
    click_on 'Salvar'
    
    expect(page).to have_content 'Bebida cadastrada com sucesso!'
    expect(page).to have_content 'Bebidas Disponíveis'
    expect(page).to have_content 'Coca-Cola'
  end
  
  it 'sem alcool com sucesso e vê detalhes' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Coca-Cola'
    fill_in 'Descrição', with: 'Refrigerante de Cola'
    fill_in 'Calorias', with: ''
    attach_file 'Foto da Bebida', Rails.root.join('spec', 'support', 'coca-cola.jpg')
    click_on 'Salvar'
    click_on 'Coca-Cola'
    
    expect(page).to have_content 'Coca-Cola'
    expect(page).to have_content 'Refrigerante de Cola'
    expect(page).to have_css("img[src*='coca-cola.jpg']")
  end

  it 'alcoolica com sucesso' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Heineken'
    fill_in 'Descrição', with: 'Cerveja puro malte'
    fill_in 'Calorias', with: '17'
    check 'Alcoólica'
    attach_file 'Foto da Bebida', Rails.root.join('spec', 'support', 'heineken.jpg')
    click_on 'Salvar'
    
    expect(page).to have_content 'Bebida cadastrada com sucesso!'
    expect(page).to have_content 'Bebidas Disponíveis'
    expect(page).to have_content 'Heineken'
  end

  it 'alcoolica com sucesso e vê detalhes' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Heineken'
    fill_in 'Descrição', with: 'Cerveja puro malte'
    fill_in 'Calorias', with: '17'
    check 'Alcoólica'
    attach_file 'Foto da Bebida', Rails.root.join('spec', 'support', 'heineken.jpg')
    click_on 'Salvar'
    click_on 'Heineken'
    
    expect(page).to have_content 'Heineken'
    expect(page).to have_content 'Cerveja puro malte'
    expect(page).to have_content 'Bebida Alcoolica! (+18)'
    expect(page).to have_css("img[src*='heineken.jpg']")
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'
    
    expect(page).to have_content 'Falha ao cadastrar bebida'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
end
