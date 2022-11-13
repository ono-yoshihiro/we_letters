class LetterDetail < ApplicationRecord
  belongs_to :send_letter
  belongs_to :type
end