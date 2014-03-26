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
    weight = data.last.values
    render :json => {
                      diabetic: diabetic,
                      days: days,
                      glucose: glucose,
                      weight: weight
                    }
  end

end
