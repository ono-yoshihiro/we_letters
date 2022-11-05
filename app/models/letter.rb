class Letter < ApplicationRecord
  has_many :combinations, dependent: :destroy
  has_many :options, through: :combinations
  belongs_to :section
  belongs_to :type
  validates :number, presence: true
end