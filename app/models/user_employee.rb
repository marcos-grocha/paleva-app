class UserEmployee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_owner
  belongs_to :establishment

  validates :name, :last_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validator

  before_validation :check_pre_registration

  private

  def cpf_validator
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end

  def check_pre_registration
    pre_registration = EmployeePreRegistration.find_by(email: self.email, cpf: self.cpf)
    if pre_registration
      self.user_owner = pre_registration.user_owner
      self.establishment = pre_registration.establishment
      pre_registration.registered!
    else
      errors.add(:base, 'Email e/ou CPF não disponível para cadastro')
    end
  end
end
