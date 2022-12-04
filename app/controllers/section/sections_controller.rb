class Section::SectionsController < ApplicationController

  def show
    @section = current_section
  end

  def edit
    @section = current_section
  end

  def update
    section = current_section
    if section.update(section_params)
      redirect_to section_path
    else
      render :edit
    end
  end

  private
  def section_params
    params.require(:section).permit(:name, :email, :pic_name, :telephone_number)
  end

end