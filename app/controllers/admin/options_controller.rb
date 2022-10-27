class Admin::OptionsController < ApplicationController

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)
    if @option.save
      redirect_to admin_options_path
    else
      render :new
    end
  end

  def show
  end

  def index
    @options = Option.all
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update(option_params)
      redirect_to admin_options_path
    else
      render :edit
    end
  end

  private
  def option_params
    params.require(:option).permit(:name, :additional_price)
  end

end