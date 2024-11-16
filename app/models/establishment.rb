class Establishment < ApplicationRecord
  belongs_to :user_owner
  has_many :dishes
  has_many :beverages
  has_many :employee_pre_registrations, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :menus, dependent: :destroy

  before_validation :generate_code, on: :create

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
