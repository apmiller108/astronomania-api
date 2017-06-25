class Apod < ApplicationRecord
  validates :date, :explanation, :title, :url, presence: true
end
