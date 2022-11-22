module PracticePdf
  class PostageSlip < Prawn::Document
    def initialize
      super(page_size: 'A4') # 新規PDF作成
      stroke_axis # 座標を表示

      font 'app/assets/fonts/SourceHanSans-Normal.ttc' # fontをパスで指定

      tytle

      move_down 20

      body

      bounding_box([100, 350], width: 200, height: 100) do
        # 周りに枠線をつける
        transparent(1) { stroke_bounds }
        font_size 16
        text '太文字'
        text 'このボックスの使い勝手はかなりいい'
      end

    end

    def tytle
      text "後納郵便物等差出票", :align => :center, :size => 10
      stroke_horizontal_rule
    end

    def body
      text "差出人氏名", :align => :right, :size => 10
      stroke_horizontal_rule
    end

  end
end