require 'rails_helper'

describe 'Usuário acessa listagem de bebidas' do
  it 'e filtra bebidas alcoólicas' do
    user_owner = create_user_owner()
    estab = create_establishment(user_owner)
    Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante', establishment: estab, alcoholic: false)
    Beverage.create!(name: 'Heineken', description: 'Cerveja', establishment: estab, alcoholic: true)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Alcoólicas'

    expect(page).to have_content 'Heineken'
    expect(page).not_to have_content 'Coca-Cola'
  end

  it 'e filtra bebidas sem alcoól' do
    user_owner = create_user_owner()
    estab = create_establishment(user_owner)
    Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante', establishment: estab, alcoholic: false)
    Beverage.create!(name: 'Heineken', description: 'Cerveja', establishment: estab, alcoholic: true)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Não Alcoólicas'

    expect(page).to have_content 'Coca-Cola'
    expect(page).not_to have_content 'Heineken'
  end
end