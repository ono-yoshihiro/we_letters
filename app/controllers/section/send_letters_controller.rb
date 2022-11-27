class Section::SendLettersController < ApplicationController

  def new
    @send_letter = SendLetter.new
    @letters = current_section.letters.all
    @payment_budgets = current_section.payment_budgets.all.where(is_deleted: true)
  end

  def create
    if SendLetter.where("created_at >= ?", Date.today).where(section_id: current_section.id).where(payment_budget_id: send_letter_params[:payment_budget_id]).present?
      redirect_to send_letters_new_path, notice: '本日の差出郵便は登録済みです。新たに登録する場合は一度取り消してください。'
    else
      @send_letter = SendLetter.new(send_letter_params)
      @send_letter.section_id = current_section.id
      @send_letter.save
      current_section.letters.each do |letter|
        letter_detail = LetterDetail.new
        letter_detail.send_letter_id = @send_letter.id
        letter_detail.type_id = letter.type_id
        letter_detail.number = letter.number
        letter_detail.save
      end
      current_section.letters.destroy_all
      redirect_to letters_path
    end
  end

  def index
    @send_letters = current_section.send_letters.all
  end

  def show
    @send_letter = SendLetter.find(params[:id])
  end

  def destroy
    send_letter = SendLetter.find(params[:id])
    letters = current_section.letters.all
    letters.destroy_all
    send_letter.letter_details.each do |letter_detail|
      Letter.create(section_id: current_section.id, type_id: letter_detail.type_id, number: letter_detail.number)
    end
    send_letter.destroy
    redirect_to letters_path
  end

  private
  def send_letter_params
    params.require(:send_letter).permit(:payment_budget_id)
  end

end