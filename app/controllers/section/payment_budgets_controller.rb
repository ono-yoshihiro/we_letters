class Section::PaymentBudgetsController < ApplicationController

  def create
    @payment_budget = PaymentBudget.new(section_id: current_section.id, budget_id: payment_budget_params[:budget_id])
    @payment_budget.save
    redirect_to budgets_path
  end

  def logical_delete
    payment_budget = PaymentBudget.find(params[:id])
    if payment_budget.is_deleted == false
      payment_budget.update(is_deleted: true)
    else
      payment_budget.update(is_deleted: false)
    end
    redirect_to budgets_path
  end

  private
  def payment_budget_params
    params.require(:payment_budget).permit(:section_id, :budget_id, :is_deleted)
  end

end
