class Admin::PostOfficesController < ApplicationController

  before_action :authenticate_admin!
  #1件のみしか登録できない想定であるため、登録済の場合は、editページへリダイレクト
  before_action :registered_post_office, if: -> { PostOffice.find(1).present? }, only: [:new]

  def new
    @post_office = PostOffice.new
  end

  def create
    @post_office = PostOffice.new(post_office_params)
    if @post_office.save
      redirect_to edit_admin_post_office_path(@post_office.id)
    else
      render :new
    end
  end

  def edit
    @post_office = PostOffice.find(params[:id])
  end

  def update
    @post_office = PostOffice.find(params[:id])
    if @post_office.update(post_office_params)
      redirect_to edit_admin_post_office_path(@post_office.id)
    else
      render :edit
    end
  end

  private
  def post_office_params
    params.require(:post_office).permit(:post_office_name, :postal_code, :sender_name, :customer_number)
  end

  def registered_post_office
    redirect_to edit_admin_post_office_path(1), notice: '集配郵便局等情報は既に登録済です。'
  end

end