class Weight < ApplicationRecord
  has_many :types

  validates :weight, presence: true
end