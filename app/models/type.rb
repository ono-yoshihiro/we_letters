class Type < ApplicationRecord
  has_many :letters
  has_many :letter_details
  belongs_to :type_name
  belongs_to :weight
  belongs_to :size
  belongs_to :address
  belongs_to :barcode
  belongs_to :delivery_date_option
  belongs_to :registered_option
  belongs_to :proof_delivery_option
  belongs_to :proof_contents_option
  belongs_to :personal_receipt_option

  def option_price
    self.delivery_date_option_price + self.registered_option_price + self.proof_delivery_option_price + self.proof_contents_option_price + self.personal_receipt_option_price
  end

  validates :type_name_id, presence: true
  validates :price, presence: true

end