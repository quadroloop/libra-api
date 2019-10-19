class Api::FeedsController < ApplicationController
  def index
    feeds = History.all
    response = feeds.map.with_index do |feed, index|
      {
        id: "item-#{index}",
        country: 'Philippines',
        country_name: feed.country_name ,
        location: feed.location ,
        source: feed.source
      }
    end

    render json: response
  end


end
