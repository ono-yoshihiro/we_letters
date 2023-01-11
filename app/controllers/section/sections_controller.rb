class Section::SectionsController < ApplicationController

  before_action :authenticate_section!
  #利用停止中の部署の利用を制限
  before_action :suspension_of_use

  def edit
    @section = current_section
  end

  def update
    @section = current_section
    if @section.update(section_params)
      redirect_to section_path
    else
      render :edit
    end
  end

  private

  def section_params
    params.require(:section).permit(:name, :email, :pic_name, :telephone_number)
  end

  def suspension_of_use
    redirect_to root_path, notice: '利用停止中です。利用を開始するには管理者に連絡してください。' unless current_section.status == true
  end

end