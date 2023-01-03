class Admin::BudgetsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @budgets = Budget.where(is_deleted: false)
    @removed_budgets = Budget.where(is_deleted: true)
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budgets = Budget.where(is_deleted: false)
    @removed_budgets = Budget.where(is_deleted: true)
    if @budget.save
      sections = Section.all
      sections.each do |section|
      PaymentBudget.create(section_id: section.id, budget_id: budget.id)
      end
      redirect_to admin_budgets_path
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
      redirect_to admin_budgets_path
    else
      render :edit
    end
  end

  def logical_delete
    budget = Budget.find(params[:id])
    if budget.is_deleted == false
      budget.update(is_deleted: true)
      redirect_to admin_budgets_path
    else
      budget.update(is_deleted: false)
      redirect_to admin_budgets_path
    end
  end

  def destroy
    budget = Budget.find(params[:id])
    if SendLetter.where(payment_budget_id: PaymentBudget.find_by(budget_id: budget.id).id).present?
      redirect_to admin_budgets_path
    else
      budget.destroy
      redirect_to admin_budgets_path
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :is_deleted)
  end

end