class Apod < ApplicationRecord
  validates :date, :explanation, :title, :url, presence: true

  scope :latest, -> { order(date: :desc).first }
end
