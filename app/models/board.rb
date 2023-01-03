class Board < ApplicationRecord

  belongs_to :section, optional: true
  validates :title, presence: true
  validates :body, presence: true

end