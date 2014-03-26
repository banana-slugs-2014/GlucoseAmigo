class GraphsController < ApplicationController

  def get_graph_data
    @data = @diabetic.get_data_for_graph
    @data.to_json
  end

  def show
    diabetic = Diabetic.find(params[:id])
    if diabetic.records.length > 1
      data = diabetic.sort_graph_data
      glucose = data.first.values
      days = data.first.keys
      time = []
      days.each do |dt|
        time_1 = dt.split[1].split(":")
        time_1.pop
        time << time_1.join(":")
      end
      comments = data[1].values
      weight = data.last.values
      last_date = days.last
      last_date = (Date.parse(last_date) - 5).to_s
      last_date_array = last_date.split.first.split("-")
      year = last_date_array[0].to_i
      month = last_date_array[1].to_i
      day = last_date_array[2].to_i
      zip_arr = comments.zip(weight)
      zip_arr_glu = time.zip(glucose)
      render :json => {
        check: 'graph',
        year: year,
        month: month,
        day: day,
        diabetic: diabetic,
        days: days,
        glucose: zip_arr_glu,
        weight: zip_arr,
        comments: comments
      }
    else
      render :json => {
        check: "error",
        alert: 'No Records'
      }
    end
  end

end
