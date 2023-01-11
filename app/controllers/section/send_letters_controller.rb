class Section::SendLettersController < ApplicationController

  before_action :authenticate_section!, only: [:new, :create, :destroy]
  #index,showはadminも参照できるようするため別で規定
  before_action :non_login, only: [:index, :show]
  #利用停止中の部署の利用を制限(send_letterのnew,createに関しては前段のletter_controllerではじかれる想定だが、念の為規定する。)
  before_action :suspension_of_use, only: [:new, :create, :destroy]

  def new
    @send_letter = SendLetter.new
    @letters = current_section.letters.order("type_id")
    @payment_budgets = current_section.payment_budgets.where(registration: true)
  end

  def create
    if send_letter_params[:payment_budget_id] == ""
      redirect_to new_send_letter_path, notice: '支払予算を選択してください。'
    elsif SendLetter.where("created_at >= ?", Date.today).where(section_id: current_section.id).where(payment_budget_id: send_letter_params[:payment_budget_id]).present?
      redirect_to new_send_letter_path, notice: '選択した支払予算で本日の差出郵便は登録済です。新たに登録する場合は一度取り消してください。'
    else
      @send_letter = SendLetter.new(section_id: current_section.id, payment_budget_id: send_letter_params[:payment_budget_id])
      @send_letter.save
      current_section.letters.each do |letter|
        LetterDetail.create(send_letter_id: @send_letter.id, type_id: letter.type_id, number: letter.number)
      end
      current_section.letters.destroy_all
      redirect_to root_path
    end
  end

  def index
    @send_letters = current_section.send_letters.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @send_letter = SendLetter.find(params[:id])
    @letter_details = @send_letter.letter_details
  end

  def destroy
    send_letter = SendLetter.find(params[:id])
    #ステータスが確定の場合は、削除ボタンを表示しないが、念の為削除操作がされた場合を規定しておく。
    if send_letter.status == true
      redirect_to new_send_letter_path, notice: '確定されているため削除できません。削除するには管理者に連絡してください。'
    else
      letters = current_section.letters.all
      letters.destroy_all
      send_letter.letter_details.each do |letter_detail|
        Letter.create(section_id: current_section.id, type_id: letter_detail.type_id, number: letter_detail.number)
      end
      send_letter.destroy
      redirect_to letters_path
    end
  end

  private

  def send_letter_params
    params.require(:send_letter).permit(:payment_budget_id)
  end

  def non_login
    redirect_to root_path unless section_signed_in? || admin_signed_in?
  end

  def suspension_of_use
    redirect_to root_path, notice: '利用停止中です。利用を開始するには管理者に連絡してください。' unless current_section.status == true
  end

end