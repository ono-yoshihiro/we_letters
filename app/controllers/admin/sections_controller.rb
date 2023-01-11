class Admin::SectionsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @sections = Section.all
  end

  def logical_delete
    section = Section.find(params[:id])
    payment_budgets = PaymentBudget.where(section_id: section.id)
    budgets = Budget.all
    if section.status == true
      section.update(status: false)
#      payment_budgets.destroy_all
    else
      section.update(status: true)
        budgets.each do |budget|
          if !PaymentBudget.where(section_id: section.id).where(budget_id: budget.id).present?
            PaymentBudget.create(section_id: section.id, budget_id: budget.id)
          end
        end
    end
    redirect_to admin_sections_path
  end

end