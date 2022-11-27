class Admin::PostOfficesController < ApplicationController

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
      redirect_to admin_post_office_path(@post_office.id)
    else
      render :edit
    end
  end

  private
  def post_office_params
    params.require(:post_office).permit(:post_office_name, :postal_code, :sender_name, :customer_number)
  end

end