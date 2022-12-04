class LetterDetail < ApplicationRecord
  belongs_to :send_letter
  belongs_to :type

  def subtotal_price
    if self.applicable_price == nil
      0
    else
      (self.applicable_price + type.option_price) * self.number
    end
  end

end