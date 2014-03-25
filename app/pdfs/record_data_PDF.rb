class RecordDataPdf

  def initialize(data, diabetic)
    @pdf = Prawn::Document.new
    @weight_data = data[1]
    @glucose_data = data[0]
    @diabetic = diabetic
    #rainbow
    logo
    @pdf.text '                     '
    @pdf.text "Data for #{@diabetic.name}"
    @pdf.text '                     '
    weight_graph
    glucose_graph
  end

  def render
    @pdf.render
  end

  private

  def background
    @pdf.fill_color "FFFF99"
    @pdf.fill_rectangle([-50,850], 1150, 900)
    @pdf.fill_color "000000"
  end

  def weight_graph
    @pdf.fill_color "000000"
    @weight_data = Hash[@weight_data.sort]
    x = 1
    @weight_data.each do |date, reading|
      @pdf.table([["WEIGHT"],["Time of reading", "Reading"]]) if x == 1
      @pdf.table([["#{date}", "#{reading}"]])
      x += 1
    end
    @pdf.text '                      '
  end

  def glucose_graph
    @pdf.fill_color "000000"
    @glucose_data = Hash[@glucose_data.sort]
    x = 1
    @glucose_data.each do |date, reading|
      @pdf.table([["GLUCOSE"],["Time of reading", "Reading"]]) if x == 1
      @pdf.table([["#{date}:", "#{reading}"]])
      x += 1
    end
    @pdf.text '                     '
  end


  def logo
    @pdf.stroke_horizontal_rule
    @pdf.pad(20) { @pdf.text "Tracking Data brought to you by GlucoseAmigo", color: 'ff0000' }
    @pdf.stroke_horizontal_rule

    #filename = "#{Rails.root}/small_logo.png"
    #@pdf.image filename
  end



  def rainbow
    @pdf.save_graphics_state do
     @pdf.soft_mask do
     0.upto 15 do |i|
       @pdf.fill_color 0, 0, 0, 100.0 / 16.0 * (15 - i)
       @pdf.fill_circle [75 + i * 25, 100], 60
      end
     end
     @pdf.fill_color '009ddc'
     @pdf.fill_rectangle [0, 60], 600, 20
     @pdf.fill_color '963d97'
     @pdf.fill_rectangle [0, 80], 600, 20
     @pdf.fill_color 'e03a3e'
     @pdf.fill_rectangle [0, 100], 600, 20
     @pdf.fill_color 'f5821f'
     @pdf.fill_rectangle [0, 120], 600, 20
     @pdf.fill_color 'fdb827'
     @pdf.fill_rectangle [0, 140], 600, 20
     @pdf.fill_color '61bb46'
     @pdf.fill_rectangle [0, 160], 600, 20
    end
  end



end