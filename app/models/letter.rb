class Letter < ApplicationRecord
  belongs_to :section
  belongs_to :type
  validates :number, presence: true
end