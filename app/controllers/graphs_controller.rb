class GraphsController < ApplicationController

  def get_graph_data
    @data = @diabetic.get_data_for_graph
    @data.to_json
  end

  def show
    # diabetic = Diabetic.find(params[:id])
    diabetic = Diabetic.find(1)
    data = diabetic.sort_graph_data
    glucose = data.first.values
    days = data.first.keys
    comments = data[1].values
    weight = data.last.values
    last_date = days.last
    last_date = (Date.parse(last_date) - 5).to_s
    last_date_array = last_date.split.first.split("-")
    year = last_date_array[0].to_i
    month = last_date_array[1].to_i
    day = last_date_array[2].to_i
    render :json => {
      year: year,
      month: month,
      day: day,
      diabetic: diabetic,
      days: days,
      glucose: glucose,
      weight: weight
    }
  end

end
