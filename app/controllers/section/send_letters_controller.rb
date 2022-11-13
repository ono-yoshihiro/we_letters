class Section::SendLettersController < ApplicationController

  def new
    @send_letter = SendLetter.new
    @letters = current_section.letters.all
    @payment_budgets = current_section.payment_budgets.all.where(is_deleted: true)
  end

  def create
    @send_letter = SendLetter.new(send_letter_params)
    @send_letter.section_id = current_section.id
    @send_letter.save
      current_section.letters.each do |letter|
        @letter_detail = LetterDetail.new
        @letter_detail.send_letter_id = @send_letter.id
        @letter_detail.type_id = letter.type_id
        #@letter_detailのapplicable_priceは集約時に決定
        @letter_detail.number = letter.number
        @letter_detail.save
      end
      current_section.letters.destroy_all
      redirect_to letters_path
  end

  def index
    @send_letters = current_section.send_letters.all
  end

  def show
    @send_letter = SendLetter.find(params[:id])
  end

  private
  def send_letter_params
    params.require(:send_letter).permit(:payment_budget_id)
  end

end