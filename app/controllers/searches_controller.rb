class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    client_id = "CO3LIXJPH1LYAC5OOTLKLJE334NVDIYG24KUFOVEQ22WVYDP"
    client_secret = "0NNKMRWRYLCKLPSEE3G10I33WV0BTYXEN2JCJ41TVKKWB52Y"
    zipcode = params[:zipcode]
    foursquare = FoursquareService.new
    @resp = foursquare.foursquare(client_id, client_secret, zipcode)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
