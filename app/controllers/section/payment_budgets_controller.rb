class Section::PaymentBudgetsController < ApplicationController

  def create
    @payment_budget = PaymentBudget.new(section_id: current_section.id, budget_id: payment_budget_params[:budget_id])
    if @payment_budget.save
      redirect_to budgets_path
    else
      render :index
    end
  end

  private

  def payment_budget_params
    params.require(:payment_budget).permit(:section_id, :budget_id)
  end

end
