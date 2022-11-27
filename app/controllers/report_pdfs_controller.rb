class ReportPdfsController < ApplicationController
  def index
#    letter_detail_same_type_ids = LetterDetail.select(:type_id).distinct

    letter_detail_same_type_ids = LetterDetail.where("created_at >= ?", Date.today).select(:type_id).distinct
    @types = Type.where(id: letter_detail_same_type_ids)
    respond_to do |format|
      format.html
      format.pdf do

        pdf = ReportPdf.new(@types)

        send_data pdf.render,
          filename:    "report.pdf",
          type:        "application/pdf",
          disposition: "inline"
      end
    end
  end
end