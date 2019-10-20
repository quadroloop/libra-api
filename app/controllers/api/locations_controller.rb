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

    locations = History.where(condition, query)
  end

  def map_danger_index(filteredFeeds, query)
    danger_index = get_danger_index(filteredFeeds)

    danger_count = danger_index.select{|k,v| v == true}.count

    danger_percentage = (danger_count.to_f / History::DEFAULT_HAZARDS.count.to_f ) * 100

    danger_percentage.to_f / 10

  end

  def get_danger_index(query)
    danger_index = {}
    History::DEFAULT_HAZARDS.each do |hazard|
      danger_index[hazard.to_sym] = query.select{|q|q['hazard'] == hazard}.present?
    end

    danger_index.stringify_keys

  end

  def format_response(filteredFeeds, location_danger_index)
    data_source = filteredFeeds.pluck(:source).uniq
    hazards = filteredFeeds.pluck(:hazard).uniq

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

