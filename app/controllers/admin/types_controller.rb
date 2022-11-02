class Admin::TypesController < ApplicationController

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
    if @type.save
      redirect_to admin_types_path
    else
      render :new
    end
  end

  def index
    @types = Type.all
  end

  def show
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
    params.require(:type).permit(:type_name_id, :weight_id, :size_id, :address_id, :barcode_id, :price, :special_price_1, :special_price_2, :special_price_3)
  end


end