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

  def open_now?
    current_time = Time.zone.now
    current_day = current_time.strftime('%A').downcase # Exemplo: "monday", "tuesday"
    
    return false unless self.send(current_day) # Verifica se o restaurante abre hoje

    opening_time_today = opening_time
    closing_time_today = closing_time

    if opening_time_today.present? && closing_time_today.present?
      current_time_in_seconds = current_time.seconds_since_midnight
      opening_time_in_seconds = opening_time_today.seconds_since_midnight
      closing_time_in_seconds = closing_time_today.seconds_since_midnight

      if opening_time_in_seconds < closing_time_in_seconds
        # Horário normal (ex.: 08:00 a 20:00)
        current_time_in_seconds.between?(opening_time_in_seconds, closing_time_in_seconds)
      else
        # Horário cruzando meia-noite (ex.: 23:50 a 09:40)
        current_time_in_seconds >= opening_time_in_seconds || current_time_in_seconds < closing_time_in_seconds
      end
    else
      false
    end
  end

  private

  def generate_code
    if ENV['SEED_MODE'] == 'true'
      self.code = 'N9KN8J'
    else
      self.code = SecureRandom.alphanumeric(6).upcase
    end
  end

  def cnpj_validator
    errors.add(:cnpj, 'inválido') unless CNPJ.valid?(cnpj)
  end
end
