class PaymentBudget < ApplicationRecord

  belongs_to :section
  belongs_to :budget

  validates :section_id, presence: true
  validates :budget_id, presence: true

end