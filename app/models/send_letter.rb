class SendLetter < ApplicationRecord
  has_many :letter_details, dependent: :destroy
  belongs_to :section
  belongs_to :payment_budget
  validates :payment_budget_id, presence: true

  def total_number
    self.letter_details.sum(:number)
  end

  def total_price
    array = []
    self.letter_details.each do |letter_detail|
      array << letter_detail.subtotal_price
    end
    array.sum
  end

end