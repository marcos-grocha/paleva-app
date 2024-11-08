require 'rails_helper'

describe 'Usuário cadastra uma porção' do
  it 'de prato com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Adicionar Porção'
    fill_in 'Descrição', with: 'Porção pequena (350ml)'
    fill_in 'Preço', with: 18.00
    click_on 'Criar Porção'

    expect(page).to have_content 'Porção cadastrada com sucesso.'
    expect(page).to have_content 'Porção pequena (350ml)'
    expect(page).to have_content 'R$ 18,00'
  end

  it 'de bebida com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Refri'
    click_on 'Adicionar Porção'
    fill_in 'Descrição', with: 'Longneck (355ml)'
    fill_in 'Preço', with: 15.00
    click_on 'Criar Porção'

    expect(page).to have_content 'Porção cadastrada com sucesso.'
    expect(page).to have_content 'Longneck (355ml)'
    expect(page).to have_content 'R$ 15,00'
  end

  it 'de prato com dados errados' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Adicionar Porção'
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Criar Porção'

    expect(page).to have_content 'Não foi possível cadastrar a porção.'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Preço não pode ficar em branco'
  end
  
  it 'de bebida com dados errados' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Refri'
    click_on 'Adicionar Porção'
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Criar Porção'

    expect(page).to have_content 'Não foi possível cadastrar a porção.'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Preço não pode ficar em branco'
  end
end