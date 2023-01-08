class Section::PaymentBudgetsController < ApplicationController

  before_action :authenticate_section!
  #利用停止中の部署の利用を制限
  before_action :suspension_of_use

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

  private

  def suspension_of_use
    redirect_to root_path, notice: '利用停止中です。利用を開始するには管理者に連絡してください。' unless current_section.status == false
  end

end
