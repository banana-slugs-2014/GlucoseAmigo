class GraphsController < ApplicationController

  def show
    diabetic = Diabetic.find(params[:id])
    if diabetic.records.length >= 1
      data = diabetic.sort_graph_data
      days = data.first.keys
      days_formatted = Graph.format_days(days)
      last_date_array = Graph.last_date(days)
      render :json => {
        check: 'graph',
        num_of_days: days_formatted.uniq.count,
        year: last_date_array[0].to_i,
        month: last_date_array[1].to_i,
        day: last_date_array[2].to_i,
        diabetic: diabetic,
        days: days_formatted,
        glucose: data.first.values,
        weight: data.last.values
      }
    else
      render :json => {
        check: "error",
        alert: 'No Records'
      }
    end
  end

end
