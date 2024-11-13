class EmployeePreRegistration < ApplicationRecord
  belongs_to :user_owner
  belongs_to :establishment

  enum :status, { pending: false, registered: true }, default: false

  validates :email, :cpf, presence: true
  validates :email, :cpf, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'inválido' }
  validate :cpf_validator

  private

  def cpf_validator
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end
end
