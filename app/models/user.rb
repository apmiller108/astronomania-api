class User < ApplicationRecord
  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.downcase.gsub(/\s+/, '')
  end
end
