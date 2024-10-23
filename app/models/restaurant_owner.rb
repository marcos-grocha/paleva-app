class RestaurantOwner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :last_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  # validate :cpf_validator
  
  def description
    "#{name} <#{email}>"
  end

  private

  def cpf_validator
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end
end
