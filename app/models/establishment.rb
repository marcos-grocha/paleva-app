class Establishment < ApplicationRecord
  belongs_to :user_owner

  before_validation :generate_code

  validates :code, :fantasy_name, :corporate_name, :cnpj, :address, :telephone, :email, presence: true
  validates :code, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'inválido' }
  validates :telephone, length: { in: 10..11, message: 'deve conter 10 ou 11 dígitos' }
  validate :cnpj_validator

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end

  def cnpj_validator
    errors.add(:cnpj, 'inválido') unless CNPJ.valid?(cnpj)
  end
end
