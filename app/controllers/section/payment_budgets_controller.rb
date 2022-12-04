class Section::PaymentBudgetsController < ApplicationController

  def index
    @payment_budgets = PaymentBudget.where(section_id: current_section.id).where(registration: true)
    @unregistered_payment_budgets = PaymentBudget.where(section_id: current_section.id).where(registration: false)
  end

  def register
    payment_budget = PaymentBudget.find(params[:id])
    if payment_budget.registration == false
      payment_budget.update(registration: true)
    else
      payment_budget.update(registration: false)
    end
    redirect_to payment_budgets_path
  end

end
