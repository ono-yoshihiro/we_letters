class Section::LettersController < ApplicationController

  def index
    @letters = current_section.letters.all
#    @form = LettersForm.new
##FormObject切り替え前
    @letter = Letter.new
  end

#  def create
#    @form = LettersForm.new(letters_form_params)
#    if @form.save
#      redirect_to letters_path
#    else
#      render :index
#    end
#  end

##FormObject切り替え前
  def create
    type_id = Type.find_by(type_name_id: letter_params[:type_name_id], weight_id: letter_params[:weight_id], size_id: letter_params[:size_id], address_id: letter_params[:address_id], barcode_id: letter_params[:barcode_id]).id
    @letter = Letter.new(type_id: type_id, section_id: current_section.id, number: letter_params[:number])
    if @letter.save
      redirect_to letters_path
    else
      render :index
    end
  end


#@form = LettersForm.new(letter_params)
#@letterが持つoptions(中間テーブルcombinationを経由)も一緒に登録したいので、FormObjectを使う予定

#送信したtype_idが既に存在する場合、numberを加算する
#    if current_section.letters.find_by(type_id: params[:letter][:type_id]).present?
#      letter.number += params[:letter][:number].to_i
#      letter.save
#      redirect_to letters_path
#    elsif letter.save
#      redirect_to letters_path
#    else
#      render :index
#    end


  def update
  end

  def destroy
  end

  def destroy_all
  end

  private

#  def letters_form_params
#    params.require(:letters_form).permit(:number, :type_name_id, :weight_id, :size_id, :address_id, :barcode_id, { option_ids: [] }).merge(section_id: current_section.id)
#  end
  def letter_params
    params.require(:letter).permit(:section_id, :type_id, :number, :type_name_id, :weight_id, :size_id, :address_id, :barcode_id)
  end

end