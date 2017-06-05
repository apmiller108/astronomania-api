class User < ApplicationRecord
  has_secure_password
  before_validation :normalize_email, unless: -> { email.blank? }

  validates :email,
            presence: true,
            format: /\A.+@.+\z/i,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 }

  validates :password,
            length: { minimum: 8 },
            confirmation: true

  validates :password_confirmation,
            presence: true

  private

  def normalize_email
    self.email = email.downcase.gsub(/\s+/, '')
  end
end
