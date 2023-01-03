class Admin::SectionsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @sections = Section.all
  end

  def logical_delete
    section = Section.find(params[:id])
    payment_budgets = PaymentBudget.where(section_id: section.id)
    budgets = Budget.all
    if section.status == false
      section.update(status: true)
      payment_budgets.destroy_all
    else
      section.update(status: false)
      budgets.each do |budget|
        PaymentBudget.create(section_id: section.id, budget_id: budget.id)
      end
    end
    redirect_to admin_sections_path
  end

end