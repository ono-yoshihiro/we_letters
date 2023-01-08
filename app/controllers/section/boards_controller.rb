class Section::BoardsController < ApplicationController

#管理者としても部署としてもログインしていない場合の利用を制限
before_action :non_login

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if section_signed_in?
      @board.section_id = current_section.id
    end
    if @board.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    redirect_to root_path
  end

  def board_params
    params.require(:board).permit(:title, :body)
  end

  def non_login
    redirect_to root_path unless section_signed_in? || admin_signed_in?
  end

end