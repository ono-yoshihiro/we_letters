class Letter < ApplicationRecord
  belongs_to :section
  belongs_to :type
  validates :number, numericality: { only_integer: true }
  validates :number, presence: true
end