require 'rails_helper'

describe 'Usuário acessa listagem de bebidas' do
  it 'e vê detalhes de uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on beverage.name

    expect(page).to have_content beverage.name
    expect(page).to have_content beverage.description
    expect(current_path).to eq beverage_path(beverage)
  end

  it 'e escolhe por listar apenas bebidas alcoólicas' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    refrigerante = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante', establishment: establishment, alcoholic: false)
    cerveja = Beverage.create!(name: 'Heineken', description: 'Cerveja', establishment: establishment, alcoholic: true)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Alcoólicas'

    expect(page).to have_content cerveja.name
    expect(page).not_to have_content refrigerante.name
  end

  it 'e escolhe por listar apenas bebidas sem alcoól' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    refrigerante = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante', establishment: establishment, alcoholic: false)
    cerveja = Beverage.create!(name: 'Heineken', description: 'Cerveja', establishment: establishment, alcoholic: true)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Não Alcoólicas'

    expect(page).to have_content refrigerante.name
    expect(page).not_to have_content cerveja.name
  end
end