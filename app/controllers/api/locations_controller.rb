class Api::LocationsController < ApplicationController

  def index
    query = params[:location].downcase

    filteredFeeds = findLocation(query)

    return no_found_location_response unless filteredFeeds

    location_danger_index = Location.new(filteredFeeds).compute_danger_index

    response = format_response(filteredFeeds, location_danger_index)

    render json: response
  end

  private

  def findLocation(query)
    condition = 'lower(location) = ?'

    locations_from_db = History.where(condition, query)

    earthquake_feeds = EarthquakeData.parsed_unknown_number_of_deaths

    locations_from_json = earthquake_feeds.select{|f| f['location'].downcase == query}

    locations_from_db + locations_from_json

  end

  def format_response(filteredFeeds, location_danger_index)
    data_source = filteredFeeds.map{|q| q['source']}.uniq
    hazards = filteredFeeds.map{|q| q['hazard']}.uniq

    lat_long = Location.new(filteredFeeds).get_lat_long

    {
      country_name: filteredFeeds[0].country_name,
      city_name: filteredFeeds[0].location,
      danger_index: location_danger_index,
      data_source: data_source,
      hazards: hazards,
      lat: lat_long['lat'],
      long: lat_long['long'],
      history: filteredFeeds
    }

  end

  def no_found_location_response
    render json: { error: 'No Location Founds' }, status: :not_found


  end

end

