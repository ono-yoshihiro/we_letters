class Admin::SendLettersController < ApplicationController

  before_action :authenticate_admin!

  def update_all
    send_letters = SendLetter.where("created_at >= ?", Date.today)
      if send_letters.exists?(status: false)
        send_letters.update_all(status: true)
        #各差出郵便の差出郵便詳細に適用料金を差し込む
        send_letters.each do |send_letter|
          send_letter.letter_details.each do |letter_detail|
            #type_id:46を判定(25g以内郵便区内バーコード有)
            if letter_detail.type_id == 46
              #1000通以上ならspecial_price_3を適用
              if LetterDetail.eager_load(:type).where(type: {id: 46}).sum(:number) >= 1000
                letter_detail.update(applicable_price: letter_detail.type.special_price_3)
              #1000通未満100通以上ならspecial_price_2適用
              elsif LetterDetail.eager_load(:type).where(type: {id: 46}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_2)
              #100通未満、かつ、type_id:45と合わせて100通を超えるならspecial_price_1を適用し、type_idを45に統合
              elsif LetterDetail.eager_load(:type).where(type: {id: 46}).sum(:number) + LetterDetail.eager_load(:type).where(type: {id: 45}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1, type_id: 45)
              #それ以外（type_id:45と合わせても100通未満）なら、priceを適用し、type_idを45に統合
              else
                letter_detail.update(applicable_price: letter_detail.type.price, type_id: 45)
              end
            #対となるtype_id:45(25g以内郵便区内バーコード無)を判定
            elsif letter_detail.type_id == 45
              #type_id:46と合わせて100通以上ならspecial_price_1を適用（type_id:46が100通以上ならtype_id:45が100通未満でもspecial_price_1が適用可能なのでこのロジックで問題ない）
              if LetterDetail.eager_load(:type).where(type: {id: 45}).sum(:number) +  LetterDetail.eager_load(:type).where(type: {id: 46}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              #それ以外（type_id:46と合わせても100通未満）なら、priceを適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #同様のロジックでtype_id:92を判定(50g以内郵便区内バーコード有)
            elsif letter_detail.type_id == 92
              #1000通以上ならspecial_price_3を適用
              if LetterDetail.eager_load(:type).where(type: {id: 92}).sum(:number) >= 1000
                letter_detail.update(applicable_price: letter_detail.type.special_price_3)
              #1000通未満100通以上ならspecial_price_2適用
              elsif LetterDetail.eager_load(:type).where(type: {id: 92}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_2)
              #100通未満、かつ、type_id:180と合わせて100通を超えるならspecial_price_1を適用し、type_idを91に統合
              elsif LetterDetail.eager_load(:type).where(type: {id: 92}).sum(:number) + LetterDetail.eager_load(:type).where(type: {id: 91}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1, type_id: 91)
              #それ以外（type_id:180と合わせても100通未満）なら、priceを適用し、type_idを91に統合
              else
                letter_detail.update(applicable_price: letter_detail.type.price, type_id: 91)
              end
            #対となるtype_id:91(50g以内郵便区内バーコード無)を判定
            elsif letter_detail.type_id == 91
              #type_id:181と合わせて100通以上ならspecial_price_1を適用（type_id:92が100通以上ならtype_id:91が100通未満でもspecial_price_1が適用可能なのでこのロジックで問題ない）
              if LetterDetail.eager_load(:type).where(type: {id: 91}).sum(:number) +  LetterDetail.eager_load(:type).where(type: {id: 92}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              #それ以外（type_id:92と合わせても100通未満）なら、priceを適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #次にtype_id:137,226,315,404を判定
            elsif letter_detail.type_id == 137 or letter_detail.type_id == 226 or letter_detail.type_id == 315 or letter_detail.type_id == 404
              #100通以上ならspecial_price_1を適用
              if LetterDetail.eager_load(:type).where(type: {id: letter_detail.type_id}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #最後に残りのtype_idにpriceを適用
            else
              letter_detail.update(applicable_price: letter_detail.type.price)
            end
          end
        end
        redirect_to root_path
      else
        send_letters.update_all(status: false)
        #適用価格を削除するが、type_idを統合したものは元のidには戻らない
        send_letters.each do |send_letter|
          send_letter.letter_details.each do |letter_detail|
            letter_detail.update(applicable_price: nil)
          end
      end
      redirect_to root_path
    end
  end

  def monthly_report
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @payment_budgets = PaymentBudget.where(registration: true).order(:section_id)
    @send_letters = SendLetter.where(created_at: @month.all_month)
    @letter_details = LetterDetail.where(created_at: @month.all_month)
  end

  private
  def send_letter_params
    params.require(:send_letter).permit(:status)
  end

end