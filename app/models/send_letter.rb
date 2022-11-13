class SendLetter < ApplicationRecord
  has_many :letter_details, dependent: :destroy
  belongs_to :section
  belongs_to :payment_budget
end