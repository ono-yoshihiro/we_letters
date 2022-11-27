class ReportPdf < Prawn::Document

def initialize(types)

  super(
    page_size: 'A4',
    top_margin: 70,
    bottom_margin: 70,
    left_margin: 50,
    right_margin: 50
    )

    font 'app/assets/fonts/ipaexm.ttf'

    #差出票に載せる郵便種別のみが配列で入っている
    @types = types

    stroke_axis

    #タイトル
    title
    move_down 40

    #差出人氏名とお客様番号
    sender
    move_down 20

    #確約文
    writing
    move_down 40

    #本体の表
    body

  end

  def title
    text '後　納　郵　便　等　差　出　票', :align => :center, :size => 11
  end

  def sender
    text "#{PostOffice.find(1).sender_name}", :align => :right, :size => 11
    text "#{PostOffice.find(1).customer_number}", :align => :right, :size => 11
  end

  def writing
    text "次のとおり、後納郵便物等を差し出します。", :size => 11
    text "なお、この郵便物等は、郵便法等の法令に違反した内容の郵便物等ではないことを確約します。", :size => 11
  end

  def body
    font_size( 9 ) do
      header = [["郵便物等の種類", "特殊取扱等", "重量", "通数", "単価", "合計料金", "摘要"]]
      table header, :cell_style => { :overflow => :shrink_to_fit, :min_font_size => 8, :height => 25 }, :column_widths => [50,150,50,50,50,70,70]
      @types
      .each do |type|
        kind =
          if type.type_name_id == 1
            if type.size_id == 1
              "定形"
            else
              "定形外"
            end
          elsif type.type_name_id == 2
            if type.size_id == 5
              "はがき"
            else
              "往復はがき"
            end
          else
            "ゆうメール"
          end
        delivery_date_option =
          if type.delivery_date_option_id == 1
            ""
          else
            type.delivery_date_option.option
          end
        registered_option =
          if type.registered_option_id == 1
            ""
          else
            if type.delivery_date_option_id == 1
              type.registered_option.option
            else
              "　" + type.registered_option.option
            end
          end
        proof_delivery_option =
          if type.proof_delivery_option_id == 1
            ""
          else
            if type.delivery_date_option_id == 1 and type.registered_option_id == 1
              type.proof_delivery_option.option
            else
              "　" + type.proof_delivery_option.option
            end
          end
        proof_contents_option =
          if type.proof_contents_option_id == 1
            ""
          else
            if type.delivery_date_option_id == 1 and type.registered_option_id == 1 and type.proof_delivery_option_id == 1
              type.proof_contents_option.option
            else
              "　" + type.proof_contents_option.option
            end
          end
        personal_receipt_option =
          if type.personal_receipt_option_id == 1
            ""
          else
            if type.delivery_date_option_id == 1 and type.registered_option_id == 1 and type.proof_delivery_option_id == 1 and type.proof_contents_option_id == 1
              type.personal_receipt_option.option
            else
              "　" + type.personal_receipt_option.option
            end
          end
        option_name = delivery_date_option + registered_option + proof_delivery_option + proof_contents_option + personal_receipt_option
        total_number = LetterDetail.eager_load(:type).where(type: {id: type.id}).sum(:number)
        applicable_price = LetterDetail.find_by(type_id: type.id).applicable_price
        subtotal_price = (LetterDetail.eager_load(:type).where(type: {id: type.id}).sum(:number) * LetterDetail.find_by(type_id: type.id).applicable_price).to_s(:delimited)
        non_standard =
          if type.size_id == 4
            "規格外"
          else
            ""
          end
        special =
          if LetterDetail.find_by(type_id: type.id).applicable_price == type.price
            ""
          elsif LetterDetail.find_by(type_id: type.id).applicable_price == type.special_price_1
            if type.size_id == 4
              "　" && " 区内特別"
            else
              "区内特別"
            end
          else
            if type.size_id == 4
              "　" + " 区内特別(バーコード付)"
            else
              "区内特別(バーコード付)"
            end
          end
        summary = non_standard + special
        data = [["#{kind}","#{option_name}","#{type.weight.weight}","#{total_number}","#{applicable_price}","#{subtotal_price}","#{summary}"]]
        table data, :cell_style => { :overflow => :shrink_to_fit, :min_font_size => 8, :height => 25 }, :column_widths => [50,150,50,50,50,70,70]
      end
        i = @types.count
        empty = [["","","以内","","","",""]] * (20 - i)
        table empty, :cell_style => { :overflow => :shrink_to_fit, :min_font_size => 8, :height => 25 }, :column_widths => [50,150,50,50,50,70,70]
    end

  end

end