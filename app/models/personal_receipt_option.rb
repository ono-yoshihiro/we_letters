class PersonalReceiptOption < ApplicationRecord
  has_many :types
  validates :option, presence: true
end