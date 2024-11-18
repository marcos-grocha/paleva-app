class Order < ApplicationRecord
  belongs_to :establishment
  has_many :order_items, dependent: :destroy

  enum :status, { waiting_confirmation: 0, in_preparation: 2, cancelled: 4, ready: 6, delivered: 8 }, default: 0

  validates :customer_name, presence: true
  validate :cpf_validator, if: -> { cpf.present? }
  validate :contact_validator
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'inválido' }, if: -> { contact_email.present? }
  validates :contact_phone, length: { in: 10..11, message: 'deve conter 10 ou 11 dígitos' }, if: -> { contact_phone.present? }

  before_validation :generate_code, on: :create

  def total_price
    order_items.includes(:portion).sum { |item| item.quantity * item.portion.price }
  end

  def order_items_details
    order_items.map do |item|
      {
        dish_name: item.dish&.name,
        beverage_name: item.beverage&.name,
        portion_name: item.portion&.description,
        quantity: item.quantity,
        note: item.note
      }
    end
  end
  
  private

  def cpf_validator
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end
  
  def contact_validator
    if contact_phone.blank? && contact_email.blank?
      errors.add(:base, "Informe pelo menos um telefone ou e-mail de contato.")
    end
  end

  def generate_code
    self.order_code = SecureRandom.alphanumeric(8).upcase
  end

end
