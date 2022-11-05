class Barcode < ApplicationRecord
  has_many :types, dependent: :destroy
  validates :barcode, presence: true
end