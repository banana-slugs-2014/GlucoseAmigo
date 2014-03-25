require 'spec_helper'

describe RecordDataPdf do
  context 'Instantiation' do
    it "should be instantiate properly" do
      @chris = Diabetic.create({name:'chris', email:'chris@dbc.com', birthday: Date.today-20000 }, :without_protection => true)
      @chris.records.build(glucose: '100', weight: '175', taken_at: (Time.now-500))
      @chris.records.build(glucose: '95', weight: '173', taken_at: (Time.now-5000))
      data = @chris.get_data_for_graph
      pdf  = RecordDataPdf.new(data, @chris)
      expect(pdf).to be_a RecordDataPdf
    end
  end
end