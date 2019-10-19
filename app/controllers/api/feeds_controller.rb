class Api::FeedsController < ApplicationController
  def index
    feeds = History.all
    response = feeds.map do |feed|
      {
        id: "item-#{feed.id}",
        country_name: feed.country_name ,
        location: feed.location ,
        source: feed.source
      }
    end

    render json: response
  end


end
