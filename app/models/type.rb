class Type < ApplicationRecord
  has_many :letters
  has_many :letter_details
  belongs_to :type_name
  belongs_to :weight, optional: true
  belongs_to :size, optional: true
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

  validates :size_id, presence: true, if: -> { type_name_id == 1 || type_name_id == 2 }
  validates :weight_id, presence: true, if: -> { type_name_id == 1 || type_name_id == 3 }
  validates :price, presence: true, unless: -> { validation_context == :letter_create }

  def get_id
    if type_name_id == 2
      Type.find_by!(
        type_name_id: type_name_id,
        weight_id: 1,
        size_id: size_id,
        address_id: address_id,
        barcode_id: barcode_id,
        delivery_date_option_id: delivery_date_option_id,
        registered_option_id: registered_option_id,
        proof_delivery_option_id: proof_delivery_option_id,
        proof_contents_option_id: proof_contents_option_id,
        personal_receipt_option_id: personal_receipt_option_id
      ).id
    elsif type_name_id == 3
      Type.find_by!(
        type_name_id: type_name_id,
        weight_id: weight_id,
        size_id: 1,
        address_id: address_id,
        barcode_id: barcode_id,
        delivery_date_option_id: delivery_date_option_id,
        registered_option_id: registered_option_id,
        proof_delivery_option_id: proof_delivery_option_id,
        proof_contents_option_id: proof_contents_option_id,
        personal_receipt_option_id: personal_receipt_option_id
      ).id
    else
      Type.find_by!(
        type_name_id: type_name_id,
        weight_id: weight_id,
        size_id: size_id,
        address_id: address_id,
        barcode_id: barcode_id,
        delivery_date_option_id: delivery_date_option_id,
        registered_option_id: registered_option_id,
        proof_delivery_option_id: proof_delivery_option_id,
        proof_contents_option_id: proof_contents_option_id,
        personal_receipt_option_id: personal_receipt_option_id
      ).id
    end
  end
end