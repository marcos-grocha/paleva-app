require 'rails_helper'

describe 'Usuário busca por itens' do
  it 'mas não está autenticado' do
    visit root_path

    expect(page).not_to have_field 'Buscar Item'
    expect(page).not_to have_button 'Buscar'
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'e encontra um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: dish.name
    click_on 'Buscar'
    
    expect(page).to have_content 'Resultado da Busca: 1 item encontrado'
    expect(page).to have_content dish.name
    expect(page).to have_content 'Editar'
  end

  it 'e vê detalhes de um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: dish.name
    click_on 'Buscar'
    click_on dish.name
    
    expect(page).to have_content dish.description
  end

  it 'e edita um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: dish.name
    click_on 'Buscar'
    click_on 'Editar'
    
    expect(page).to have_content 'Edite os campos que desejar'
  end

  it 'e encontra uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: beverage.name
    click_on 'Buscar'
    
    expect(page).to have_content 'Resultado da Busca: 1 item encontrado'
    expect(page).to have_content beverage.name
    expect(page).to have_content 'Editar'
  end

  it 'e vê detalhes de uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: beverage.name
    click_on 'Buscar'
    click_on beverage.name
    
    expect(page).to have_content beverage.description
  end

  it 'e edita uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    fill_in 'Buscar Item', with: beverage.name
    click_on 'Buscar'
    click_on 'Editar'
    
    expect(page).to have_content 'Edite os campos que desejar'
  end
end