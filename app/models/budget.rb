class Budget < ApplicationRecord

  has_many :payment_budgets, dependent: :destroy

  validates :name, presence: true

end