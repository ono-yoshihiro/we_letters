class Admin::SendLettersController < ApplicationController

  def index
    @send_letters = SendLetter.where("created_at >= ?", Date.today)
  end

  def update_all
    send_letters = SendLetter.where("created_at >= ?", Date.today)
      if send_letters.exists?(status: false)
        send_letters.update_all(status: true)
        #各差出郵便の差出郵便詳細に適用料金を差し込む
        send_letters.each do |send_letter|
          send_letter.letter_details.each do |letter_detail|
            #type_id:177,441（50g以内定形外に25g以内定型外を含む）を判定
            if letter_detail.type_id == 177 or letter_detail.type_id == 441
              #合わせて100通以上ならspecial_price_1を適用し、type_idを441に統合
              if LetterDetail.eager_load(:type).where(type: {id: 177}).sum(:number) + LetterDetail.eager_load(:type).where(type: {id: 441}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1, type_id: 441)
              #合わせて100通未満ならそれぞれprice適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #次にtype_id:89を判定
            elsif letter_detail.type_id == 89
              #1000通以上ならspecial_price_3を適用
              if LetterDetail.eager_load(:type).where(type: {id: 89}).sum(:number) >= 1000
                letter_detail.update(applicable_price: letter_detail.type.special_price_3)
              #1000通未満100通以上ならspecial_price_2適用
              elsif LetterDetail.eager_load(:type).where(type: {id: 89}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_2)
              #100通未満、かつ、type_id:45と合わせて100通を超えるならspecial_price_1を適用し、type_idを45に統合
              elsif LetterDetail.eager_load(:type).where(type: {id: 89}).sum(:number) + LetterDetail.eager_load(:type).where(type: {id: 45}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1, type_id: 45)
              #それ以外（type_id:45と合わせても100通未満）なら、priceを適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #対となるtype_id:45を判定
            elsif letter_detail.type_id == 45
              #type_id:89と合わせて100通以上ならspecial_price_1を適用（type_id:89が100通以上ならtype_id:45が100通未満でもspecial_price_1が適用可能なのでこのロジックで問題ない）
              if LetterDetail.eager_load(:type).where(type: {id: 45}).sum(:number) +  LetterDetail.eager_load(:type).where(type: {id: 89}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              #それ以外（type_id:89と合わせても100通未満）なら、priceを適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #同様のロジックでtype_id:353を判定
            elsif letter_detail.type_id == 353
              #1000通以上ならspecial_price_3を適用
              if LetterDetail.eager_load(:type).where(type: {id: 353}).sum(:number) >= 1000
                letter_detail.update(applicable_price: letter_detail.type.special_price_3)
              #1000通未満100通以上ならspecial_price_2適用
              elsif LetterDetail.eager_load(:type).where(type: {id: 353}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_2)
              #100通未満、かつ、type_id:309と合わせて100通を超えるならspecial_price_1を適用し、type_idを309に統合
              elsif LetterDetail.eager_load(:type).where(type: {id: 353}).sum(:number) + LetterDetail.eager_load(:type).where(type: {id: 309}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1, type_id: 309)
              #それ以外（type_id:309と合わせても100通未満）なら、priceを適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #対となるtype_id:309を判定
            elsif letter_detail.type_id == 309
              #type_id:353と合わせて100通以上ならspecial_price_1を適用（type_id:89が100通以上ならtype_id:45が100通未満でもspecial_price_1が適用可能なのでこのロジックで問題ない）
              if LetterDetail.eager_load(:type).where(type: {id: 309}).sum(:number) +  LetterDetail.eager_load(:type).where(type: {id: 353}).sum(:number) >= 100
                letter_detail.update(applicable_price: letter_detail.type.special_price_1)
              #それ以外（type_id:353と合わせても100通未満）なら、priceを適用
              else
                letter_detail.update(applicable_price: letter_detail.type.price)
              end
            #次にtype_id:573,705,837を判定
            elsif letter_detail.type_id == 573 or letter_detail.type_id == 705 or letter_detail.type_id == 837
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
        redirect_to admin_send_letters_path
      else
        send_letters.update_all(status: false)
        #適用価格を削除するが、type_idを統合したものは元のidには戻らない
        send_letters.each do |send_letter|
          send_letter.letter_details.each do |letter_detail|
            letter_detail.update(applicable_price: nil)
          end
        end
        redirect_to admin_send_letters_path
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
