class LettersForm
  include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにする
  include ActiveModel::Attributes # ActiveRecordのカラムのような属性を加えられるようにする

  attribute :section_id, :integer
  attribute :type_name_id, :integer
  attribute :weight_id, :integer
  attribute :size_id, :integer
  attribute :address_id, :integer
  attribute :barcode_id, :integer
  attribute :number, :integer
  attribute :option_id

  validates :type_name_id, presence: true
  validates :number, presence: true

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      letter = letter.new(letter_params)
      type_id = Type.find_by(type_name_id: params[:letter][:type_name_id], weight_id: params[:letter][:weight_id], size_id: params[:letter][:size_id], address_id: params[:letter][:address_id], barcode_id: params[:letter][:barcode_id]).id
      letter.section_id = current_section.id
      letter.save!
      letter.combinations.create!(option_id: option_id, letter_id: letter.id)
    end
  end

end