class Api::FeedsController < ApplicationController
  def index
    feeds = History.all
    uniq_feeds = feeds.uniq{|feed| feed.location}
    response = uniq_feeds.map do |feed|
      {
        id: "item-#{feed.id}",
        country_name: feed.country_name ,
        location: feed.location ,
        source: feed.source
      }
    end

    render json: response
  end

  def philippines
    feeds = History.where(country_name: 'Philippines')
    filtered = feeds.uniq{|feed| feed.location}

    response = filtered.map do |feed|
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
