class Admin::SendLettersController < ApplicationController

  def index
    @send_letters = SendLetter.where("created_at >= ?", Date.today)
  end

  def update_all
    send_letters = SendLetter.where("created_at >= ?", Date.today)
    if
      send_letters.update_all(status: true)
      redirect_to admin_send_letters_path
    else
      render :index
    end
  end

  def update
    send_letter = SendLetter.find(params[:id])
    if send_letter_params[:status] == nil
      send_letter_params[:status] == false
    end
    if send_letter.update(status: send_letter_params[:status])
      redirect_to admin_send_letters_path
    else
      render :index
    end
  end

  def index_all
    @send_letters = SendLetter.all
  end

  private
  def send_letter_params
    params.require(:send_letter).permit(:status)
  end

end