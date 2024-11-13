require 'rails_helper'

describe 'Usuário busca por itens' do
  it 'mas não está logado' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    visit root_path

    expect(page).not_to have_field 'Buscar Item'
    expect(page).not_to have_button 'Buscar'
    expect(current_path).to eq pa_leva_session_path
  end

  it 'e encontra um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    Dish.create!(name: 'Arroz', description: 'Descrição do support/auto_create.rb', establishment: establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: 'Feijoada'
    click_on 'Buscar'
    
    expect(page).to have_content 'Resultado da Busca: 1 item encontrado'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Editar'
    expect(page).not_to have_content 'Arroz'
  end

  it 'e vê detalhes de um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: 'Feijoada'
    click_on 'Buscar'
    click_on 'Feijoada'
    
    expect(page).to have_content 'Descrição da feijoada'
  end

  it 'e edita um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: 'Feijoada'
    click_on 'Buscar'
    click_on 'Editar'
    
    expect(page).to have_content 'Edite os campos que desejar'
  end

  it 'e encontra uma bebida' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Beverage.create!(name: 'Coca-Cola', description: 'Descrição do support/auto_create.rb', establishment: establishment)
    Beverage.create!(name: 'Heineken', description: 'Descrição do support/auto_create.rb', establishment: establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: 'Coca-Cola'
    click_on 'Buscar'
    
    expect(page).to have_content 'Resultado da Busca: 1 item encontrado'
    expect(page).to have_content 'Coca-Cola'
    expect(page).to have_content 'Editar'
    expect(page).not_to have_content 'Heineken'
  end

  it 'e vê detalhes de uma bebida' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Beverage.create!(name: 'Coca-Cola', description: 'Descrição da coca-cola', establishment: establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: 'Coca-Cola'
    click_on 'Buscar'
    click_on 'Coca-Cola'
    
    expect(page).to have_content 'Descrição da coca-cola'
  end

  it 'e edita uma bebida' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Beverage.create!(name: 'Coca-Cola', description: 'Descrição da coca-cola', establishment: establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: 'Coca-Cola'
    click_on 'Buscar'
    click_on 'Editar'
    
    expect(page).to have_content 'Edite os campos que desejar'
  end
end