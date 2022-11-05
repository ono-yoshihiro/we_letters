class Option < ApplicationRecord
  has_many :combinations, dependent: :destroy
  validates :name, presence: true
  validates :additional_price_1, presence: true
end