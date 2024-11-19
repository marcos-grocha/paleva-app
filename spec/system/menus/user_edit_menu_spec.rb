require 'rails_helper'

describe 'Usuário edita um cardápio' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    menu = Menu.create!(name: 'Menu', establishment: establishment)

    visit edit_menu_path(menu)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está logado mas não é o dono' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    menu = Menu.create!(name: 'Menu', establishment: establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit edit_menu_path(menu)
    
    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a este cardápio.'
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)

    feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment)
    Portion.create!(description: 'Feijoada P', price: '19.00', dish: feijoada)
    coca = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establishment, alcoholic: false)
    Portion.create!(description: 'Coca P', price: '10.00', beverage: coca)
    menu = Menu.create!(name: 'Menu', establishment: establishment)
    MenuDish.create!(menu: menu, dish: feijoada)
    MenuBeverage.create!(menu: menu, beverage: coca)

    fritas = Dish.create!(name: 'Batata-Frita', description: 'Fritas em forma de tirinhas', establishment: establishment)
    Portion.create!(description: 'Batata P', price: '18.00', dish: fritas)
    heineken = Beverage.create!(name: 'Heineken', description: 'Cerveja puro-malte', establishment: establishment, alcoholic: true)
    Portion.create!(description: 'Heineken P', price: '11.00', beverage: heineken)
    
    login_as user_owner
    visit root_path
    click_on 'Cardápios'
    click_on 'Menu'
    click_on 'editar'
    check 'Batata-Frita'
    check 'Heineken'
    uncheck 'Coca-Cola'
    click_on 'Salvar'

    expect(page).to have_content 'Cardápio atualizado com sucesso.'
    expect(page).to have_content 'Pedido Atual'
    expect(page).to have_content 'Nenhum item adicionado ao pedido.'
    expect(page).to have_content 'Pratos Disponíveis'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijoada P: R$ 19,00'
    expect(page).to have_content 'Batata-Frita'
    expect(page).to have_content 'Batata P: R$ 18,00'
    expect(page).not_to have_content 'Coca-Cola'
    expect(page).not_to have_content 'Coca P: R$ 10,00'
  end
end