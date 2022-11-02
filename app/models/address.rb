class Address < ApplicationRecord
  has_many :types

  validates :address, presence: true
end