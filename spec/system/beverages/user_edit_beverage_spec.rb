require 'rails_helper'

describe 'Usuário acessa detalhes de uma bebida' do
  it 'e edita os dados' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on 'Coca-Cola'
    click_on 'editar'
    fill_in 'Descrição', with: 'Bebida com gás'
    click_on 'Salvar'

    expect(page).to have_content 'Bebida atualizado com sucesso.'
    expect(page).to have_content bebida.name
    expect(page).to have_content 'Bebida com gás'
    expect(page).not_to have_content 'Refrigerante de cola'
  end

  it 'e não está autenticado' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    visit edit_beverage_path(bebida)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'e não tem autorização pra editar' do
    impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', 
      cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    login_as impostor
    visit edit_beverage_path(bebida)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a esta bebida.'
  end
end
