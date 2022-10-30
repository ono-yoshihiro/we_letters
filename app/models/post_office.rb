class PostOffice < ApplicationRecord

  validates :name, presence: true
  validates :postal_code, presence: true

end