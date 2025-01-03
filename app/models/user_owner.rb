class UserOwner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :establishment
  has_many :menus, through: :establishment
  has_many :employee_pre_registrations, dependent: :destroy
  
  validates :name, :last_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validator

  private

  def cpf_validator
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end
end
