class Admin::SendLettersController < ApplicationController

  def index
    @send_letters = SendLetter.where("created_at >= ?", Date.today)
  end

  def update_all
    send_letters = SendLetter.where("created_at >= ?", Date.today)
      if send_letters.exists?(status: false)
        send_letters.update_all(status: true)
        ##各差出郵便の差出郵便詳細に適用料金を差し込む
        send_letters.each do |send_letter|
          send_letter.letter_details.each do |letter_detail|
            #同一の郵便種別idの合計通数を定義
            identical_type_letters_number_1 = LetterDetail.eager_load(:type).where(type: {id: letter_detail.type_id}).sum(:number)
            #同一の郵便種別名id、重量id、サイズid、宛先idでオプションの指定なし（配達日オプションidと書留オプションidが1）の合計通数を定義
            identical_type_letters_number_2 = LetterDetail.eager_load(type: [:type_name, :weight, :size, :address, :delivery_date_option, :registered_option])
                                              .where(type_name: {id: letter_detail.type.type_name_id})
                                              .where(weight: {id: letter_detail.type.weight_id})
                                              .where(size: {id: letter_detail.type.size_id})
                                              .where(address: {id: letter_detail.type.address_id})
                                              .where(delivery_date_option: {id: letter_detail.type.delivery_date_option_id})
                                              .where(registered_option: {id: letter_detail.type.registered_option_id})
                                              .sum(:number)
            #最初にオプションがついているもの（「option_priceが0でない」と同義）は全て通常料金（price）を適用
            if letter_detail.type.option_price != 0
              letter_detail.update(applicable_price: letter_detail.type.price)
            #次にtype_id:177,441のみ特殊な（50g以内定形外に25g以内定型外を含む）ため優先して判定
            elsif letter_detail.type_id == 177 or letter_detail.type_id == 441
              #100通以上ならspecial_price_1適用
              if LetterDetail.eager_load(:type).where(type: {id: 177}).sum(:number) + LetterDetail.eager_load(:type).where(type: {id: 441}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              #100通未満ならprice適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #次にspecial_price_2が0でないときは、special_price_3も0でないのでspecial_price_2が0でないときで場合分け
            elsif letter_detail.type.special_price_2 != 0
              #同一の郵便種別idの合計通数が1000通以上ならspecial_price_3適用・・・Ａ
              if identical_type_letters_number_1 >= 1000
                letter_detail.update(applicable_price: letter_detail.type.special_price_3)
              #同一の郵便種別idの合計通数が1000通未満100通以上ならspecial_price_2適用・・・Ｂ
              elsif identical_type_letters_number_1 >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_2)
              #同一の郵便種別idの合計通数が100通未満で、かつ、同一の郵便種別名id、重量id、サイズid、宛先idの合計通数が100通以上ならspecial_price_1適用・・・Ｃ
              elsif identical_type_letters_number_2 >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              #その他ならprice適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #special_price_1が0でないときで場合分け
            elsif letter_detail.type.special_price_1 != 0
              #同一の郵便種別名id、重量id、サイズid、宛先idの合計通数が100通以上（区内特別2又は区内特別3が適用されるとき、バーコードなしが100通未満でも区内特別1は適用可）ならspecial_price_1適用
              if identical_type_letters_number_1 + identical_type_letters_number_2 >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              end
            else
              letter_detail.update(applicable_price: letter_detail.type.price)
            end
          end
        end
        redirect_to admin_send_letters_path
      else
        send_letters.update_all(status: false)
        send_letters.each do |send_letter|
          send_letter.letter_details.each do |letter_detail|
            letter_detail.update(applicable_price: nil)
          end
        end
      end
  end


##個別の確定処理はしないようにしたためコメントアウトしておく
#  def update
#    send_letter = SendLetter.find(params[:id])
#    if send_letter_params[:status] == nil
#      send_letter_params[:status] == false
#    end
#    if send_letter.update(status: send_letter_params[:status])
#      redirect_to admin_send_letters_path
#    else
#      render :index
#    end
#  end

  def index_all
    @send_letters = SendLetter.all
  end

  private
  def send_letter_params
    params.require(:send_letter).permit(:status)
  end

end
