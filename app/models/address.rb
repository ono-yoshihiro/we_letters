class Address < ApplicationRecord
  has_many :types, dependent: :destroy
  validates :address, presence: true
end