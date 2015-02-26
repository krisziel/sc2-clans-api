class MiddlemanController < ApplicationController

  def load
    url = params[:url]
    if (params[:apikey])
      url += "&apikey=#{params[:apikey]}"
    end
    response = RestClient.get(url)
    render json: response
  end

end
