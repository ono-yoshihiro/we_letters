class Section::HomesController < ApplicationController

  def top
    if section_signed_in?
      @send_letters = current_section.send_letters.where("created_at >= ?", Date.today)
    elsif admin_signed_in?
      @send_letters = SendLetter.where("created_at >= ?", Date.today)
    end
  end

  def hoge
  end

end