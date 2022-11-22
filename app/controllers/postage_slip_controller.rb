class PostageSlipController < ApplicationController
  def index
    respond_to do |format|
      format.pdf do
        postage_slip = PracticePdf::PostageSlip.new().render
        send_data postage_slip,
          filename: 'postage_slip.pdf',
          type: 'application/pdf',
          disposition: 'inline' # 外すとダウンロード
      end
    end


  end
end