class PostOffice < ApplicationRecord


  validates :postal_code, presence: true

end