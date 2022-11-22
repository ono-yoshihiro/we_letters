class Section::LettersController < ApplicationController

  def index
    @letters = current_section.letters.all
    @letter = Letter.new
    @type_names = TypeName.all
    @weights = Weight.where(id: 2..10)
  end

  def create #各項目の未選択を想定しているため、あらかじめp(paramsの略意)_項目名で未選択時の値を指定
    if letter_params[:type_name_id] == nil
      p_type_name_id = 1
    else
      p_type_name_id = letter_params[:type_name_id]
    end
    if letter_params[:weight_id] == nil
      p_weight_id = 1
    else
      p_weight_id = letter_params[:weight_id]
    end
    if letter_params[:size_id] == nil
      p_size_id = 1
    else
      p_size_id = letter_params[:size_id]
    end
    if letter_params[:address_id] == nil
      p_address_id = 1
    else
      p_address_id = letter_params[:address_id]
    end
    if letter_params[:barcode_id] == nil
      p_barcode_id = 1
    else
      p_barcode_id = letter_params[:barcode_id]
    end
    if letter_params[:delivery_date_option_id] == nil
      p_delivery_date_option_id = 1
    else
      p_delivery_date_option_id = letter_params[:delivery_date_option_id]
    end
    if letter_params[:registered_option_id] == nil
      p_registered_option_id = 1
    else
      p_registered_option_id = letter_params[:registered_option_id]
    end
    if letter_params[:proof_delivery_option_id] == nil
      p_proof_delivery_option_id = 1
    else
      p_proof_delivery_option_id = letter_params[:proof_delivery_option_id]
    end
    if letter_params[:proof_contents_option_id] == nil
      p_proof_contents_option_id = 1
    else
      p_proof_contents_option_id = letter_params[:proof_contents_option_id]
    end
    if letter_params[:personal_receipt_option_id] == nil
      p_personal_receipt_option_id = 1
    else
      p_personal_receipt_option_id = letter_params[:personal_receipt_option_id]
    end
    type_id = Type.find_by(
      type_name_id: p_type_name_id,
      weight_id: p_weight_id,
      size_id: p_size_id,
      address_id: p_address_id,
      barcode_id: p_barcode_id,
      delivery_date_option_id: p_delivery_date_option_id,
      registered_option_id: p_registered_option_id,
      proof_delivery_option_id: p_proof_delivery_option_id,
      proof_contents_option_id: p_proof_contents_option_id,
      personal_receipt_option_id: p_personal_receipt_option_id
      ).id
    @letter = Letter.new(type_id: type_id, section_id: current_section.id, number: letter_params[:number])
    if current_section.letters.find_by(type_id: type_id).present?
      letter = current_section.letters.find_by(type_id: type_id)
      letter.number += letter_params[:number].to_i
      letter.save
      redirect_to letters_path
    elsif @letter.save
      redirect_to letters_path
    else
      render :index
    end
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

  def letter_params
    params.require(:letter).permit(:section_id,
                                   :type_id,
                                   :number,
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

end