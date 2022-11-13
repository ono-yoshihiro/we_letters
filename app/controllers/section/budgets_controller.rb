class Section::BudgetsController < ApplicationController

  def index
    @budgets = Budget.all
    @budget = Budget.new
    @payment_budget = PaymentBudget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to budgets_path
    else
      render :index
    end
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budgets_path
    else
      render :edit
    end
  end

  def destroy
    budget = Budget.find(params[:id])
    budget.destroy
    redirect_to budgets_path
  end

  private

  def budget_params
    params.require(:budget).permit(:name)
  end

end