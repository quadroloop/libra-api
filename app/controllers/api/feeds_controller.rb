class Api::FeedsController < ApplicationController
  def index
    feeds = History.all

    earthquake_feeds = EarthquakeData::parsed_unknown_number_of_deaths

    all_data = feeds + earthquake_feeds

    uniq_feeds = all_data.uniq{|feed| feed.location}

    parsed_feeds = format_response(uniq_feeds, all_data)

    render json: parsed_feeds
  end

  def philippines
    feeds = History.where(country_name: 'Philippines')

    earthquake_feeds = EarthquakeData::parsed_unknown_number_of_deaths

    locations_from_json = earthquake_feeds.select{|f| f['country_name'] == 'Philippines'}

    all_data = feeds + locations_from_json

    filtered = all_data.uniq{|feed| feed['location']}

     parsed_feeds = format_response(filtered, all_data)

    render json: parsed_feeds
  end

  private

  def format_response(uniq_feeds, feeds)
    feeds_result = []

    uniq_feeds.in_groups_of(600, false)  do |group|
      group.each do |feed|
        query = feeds.select{|f|f['location'] == feed.location}
        data_source = query.map{|q| q['source']}.uniq
        hazards = query.map{|q| q['hazard']}.uniq

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
    end

    feeds_result
  end

end
