class GraphsController < ApplicationController

  def get_graph_data
    @data = @diabetic.get_data_for_graph
    @data.to_json
  end

  def show
    # diabetic = Diabetic.find(params[:id])
    diabetic = Diabetic.find(1)
    glucose_data = diabetic.get_data_for_graph.first.sort_by{|a,b| a }
    weight_data = diabetic.get_data_for_graph.last.sort_by{|a,b| a }
    glucose_data = Hash[*glucose_data.flatten]
    weight_data = Hash[*weight_data.flatten]
    glucose = glucose_data.values
    days = glucose_data.keys
    weight = weight_data.values
    render :json => {
      diabetic: diabetic,
      days: days,
      glucose: glucose,
      weight: weight
    }
  end

end
