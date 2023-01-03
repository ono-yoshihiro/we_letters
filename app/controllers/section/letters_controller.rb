class Section::LettersController < ApplicationController

  before_action :authenticate_section!
  before_action :suspension_of_use
  before_action :non_payment_budget

  def index
    @letters = current_section.letters.order("type_id")
    @type = Type.new
    @letter = Letter.new
  end

  def create
    @letters = current_section.letters.order("type_id")
    @letter = Letter.new
    @type = Type.new(type_params)
    if @type.invalid?(:letter_create)
      @letter = Letter.new(type_id: Type.take.id, section_id: current_section.id, number: letter_params[:number])
      @letter.invalid?
      return render :index
    end
    type_id = @type.get_id
    @letter = Letter.new(type_id: type_id, section_id: current_section.id, number: letter_params[:number])
    return render :index if @letter.invalid?

    letter = current_section.letters.find_by(type_id: type_id)

    if letter.present?
      letter.number += @letter.number
      letter.save!
    else
      @letter.save!
    end

    redirect_to letters_path
  end

  def update
    letter = Letter.find(params[:id])
    letter.update(letter_params)
    redirect_to letters_path
  end

  def destroy
    letter = Letter.find(params[:id])
    letter.destroy
    redirect_to letters_path
  end

  def destroy_all
    letters = current_section.letters.all
    letters.destroy_all
    redirect_to letters_path
  end


  private

  def type_params
    params.require(:type).permit(:section_id,
                                 :type_id,
                                 :type_name_id,
                                 :weight_id,
                                 :size_id,
                                 :address_id,
                                 :barcode_id,
                                 :delivery_date_option_id,
                                 :registered_option_id,
                                 :proof_delivery_option_id,
                                 :proof_contents_option_id,
                                 :personal_receipt_option_id
                                 )
  end

  def letter_params
    params.require(:letter).permit(:number)
  end

  def suspension_of_use
    redirect_to root_path, notice: '利用停止中です。利用を開始するには管理者に連絡してください。' unless current_section.status == false
  end

  def non_payment_budget
    redirect_to root_path, notice: '登録済の支払予算がありません。「支払予算の登録」メニューから支払予算を登録してください。' unless current_section.payment_budgets.where(registration: true).present?
  end

end