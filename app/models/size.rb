class Size < ApplicationRecord
  has_many :types
  validates :size, presence: true
end