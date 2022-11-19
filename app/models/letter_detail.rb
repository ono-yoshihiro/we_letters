class LetterDetail < ApplicationRecord
  belongs_to :send_letter
  belongs_to :type

  def subtotal_price
    (self.applicable_price + type.option_price) * self.number
  end

end