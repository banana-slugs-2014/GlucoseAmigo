class RecordDataPdf

  def initialize (data, diabetic)
    @pdf = Prawn::Document.new
puts "================="
p data
    @weight_data = data[1]
    @glucose_data = data[0]
    @diabetic = diabetic
    rainbow
    logo
    @pdf.text "Data for #{@diabetic.name}"
    weight_graph
    glucose_graph
  end

  def weight_graph
    @pdf.text "Weight data:"
    @weight_data.each do |date, reading|
      @pdf.text "#{date}: #{reading}"
    end
  end

  def glucose_graph
    @pdf.text "Glucose data:"
    @glucose_data.each do |date, reading|
      @pdf.text "#{date}: #{reading}"
    end
  end

  def render
    @pdf.render
  end

  def logo
    @pdf.stroke_horizontal_rule
    @pdf.pad(20) { @pdf.text "Tracking Data brought to you by GlucoseAmigo", color: 'ff0000' }
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