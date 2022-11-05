class LettersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :section_id, :integer
  attribute :type_id, :integer
  attribute :type_name_id, :integer
  attribute :weight_id, :integer
  attribute :size_id, :integer
  attribute :address_id, :integer
  attribute :barcode_id, :integer
  attribute :number, :integer
  attribute :option_id, :integer
  attribute :option_ids

  validates :type_name_id, presence: true
  validates :number, presence: true

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      type_id = Type.find_by(type_name_id: letters_form_params[:type_name_id], weight_id: letters_form_params[:weight_id], size_id: letters_form_params[:size_id], address_id: letters_form_params[:address_id], barcode_id: letters_form_params[:barcode_id]).id
      letter = letter.new(type_id: type_id, section_id: current_section.id, number: letters_form_params[:number])
      letter.save
#      combination = Combination.new(letter_id: letter.id, option_id: letters_form_params[:option_id])
#      conbination.save
    end
  end

end