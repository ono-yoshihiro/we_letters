class Type < ApplicationRecord
  has_many :letters
  has_many :letter_details
  #種別が消えても履歴は残したいため、dependent: :destroy　は記述していない。エラーが出るか？

  validates :name, presence: true
  validates :price, presence: true

end