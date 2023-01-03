class PostOffice < ApplicationRecord

  validates :post_office_name, presence: true
  validates :postal_code, presence: true
  validates :sender_name, presence: true
  validates :customer_number, numericality: { only_integer: true }, length: { is: 32 }

end