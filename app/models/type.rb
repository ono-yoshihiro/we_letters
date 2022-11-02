class Type < ApplicationRecord
  has_many :letters
  has_many :letter_details
  belongs_to :type_name
  belongs_to :weight, optional: true
  belongs_to :size, optional: true
  belongs_to :address, optional: true
  belongs_to :barcode, optional: true
  #種別が消えても履歴は残したいため、dependent: :destroy　は記述していない。エラーが出るか？

  #enum weight: { blank_weight: 0, up_to_25g: 1, up_to_50g: 2, up_to_100g: 3, up_to_150g: 4, up_to_250g: 5, up_to_500g: 6, up_to_1kg: 7, up_to_2kg: 8, up_to_4kg: 9 }

  #enum size: { blank_size: 0, fixed_form: 1, standard: 2, nonstandard: 3 }

  validates :type_name_id, presence: true
  validates :price, presence: true

end