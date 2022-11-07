class Section::SendLettersController < ApplicationController

  def new
    @send_letter = SendLetter.new
    @letters = current_section.letters.all
  end

end