class Section::BudgetsController < ApplicationController

  def index
    @budgets = Budget.where(is_deleted: false)
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      sections = Section.all
      sections.each do |section|
      PaymentBudget.create(section_id: section.id, budget_id: @budget.id)
      end
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

  def logical_delete
    budget = Budget.find(params[:id])
    budget.update(is_deleted: true)
    redirect_to budgets_path
  end

  private
  def budget_params
    params.require(:budget).permit(:name, :is_deleted)
  end

end