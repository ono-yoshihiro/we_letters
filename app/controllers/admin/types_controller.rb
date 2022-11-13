class Admin::TypesController < ApplicationController

  def index
    @types = Type.page(params[:page]).per(8)
  end

  def edit
    @type = Type.find(params[:id])
  end

  def update
    @type = Type.find(params[:id])
    if @type.update(type_params)
      redirect_to admin_types_path
    else
      render :edit
    end
  end

  private
  def type_params
    params.require(:type).permit(:type_name_id, :weight_id, :size_id, :address_id, :barcode_id, :price, :special_price_1, :special_price_2, :special_price_3, :delivery_date_option_id, :registered_option_id, :proof_delivery_option_id, :proof_contents_option_id, :personal_receipt_option_id, :delivery_date_option_price, :registered_option_price, :proof_delivery_option_price, :proof_contents_option_price, :personal_receipt_option_price)
  end


end