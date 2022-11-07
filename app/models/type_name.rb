class TypeName < ApplicationRecord
  has_many :types
  validates :type_name, presence: true
end