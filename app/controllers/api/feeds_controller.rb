class Api::FeedsController < ApplicationController
  def index
    feeds = History.all
    uniq_feeds = feeds.uniq{|feed| feed.location}

    parsed_feeds = format_response(uniq_feeds, feeds)

    render json: parsed_feeds
  end

  def philippines
    feeds = History.where(country_name: 'Philippines')
    filtered = feeds.uniq{|feed| feed.location}

     parsed_feeds = format_response(filtered, feeds)

    render json: parsed_feeds
  end

  private

  def format_response(uniq_feeds, feeds)
    feeds_result = []

    uniq_feeds.each do |feed|
      query = feeds.where(location: feed.location)
      data_source = query.pluck(:source).uniq
      hazards = query.pluck(:hazard).uniq

      lat_long = Location.new(query).get_lat_long

      feeds_result << {
                  country_name: feed['country_name'],
                  city_name: feed['location'],
                  danger_index: Location.new(query).compute_danger_index,
                  data_source: data_source,
                  hazards: hazards,
                  lat: lat_long['lat'],
                  long: lat_long['long']
               }

    end

    feeds_result
  end

end
