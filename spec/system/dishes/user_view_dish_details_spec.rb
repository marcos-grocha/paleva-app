require 'rails_helper'

describe 'Usuário acessa listagem de pratos' do
  it 'e vê detalhes de um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on dish.name

    expect(page).to have_content dish.name
    expect(page).to have_content dish.description
    expect(current_path).to eq dish_path(dish)
  end
end