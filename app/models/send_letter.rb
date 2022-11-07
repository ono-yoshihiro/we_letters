class SendLetter < ApplicationRecord
  has_many :letter_details, dependent: :destroy
end