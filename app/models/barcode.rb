class Barcode < ApplicationRecord
  has_many :types

  validates :barcode, presence: true
end