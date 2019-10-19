class Api::FeedsController < ApplicationController
  def index
    feeds = History.all
    uniq_feeds = feeds.uniq{|feed| feed.location}
    render json: map_danger_index(uniq_feeds)
  end

  def philippines
    feeds = History.where(country_name: 'Philippines')
    filtered = feeds.uniq{|feed| feed.location}
    render json: map_danger_index(filtered)
  end

  private def map_danger_index(filteredFeeds)
    filteredFeeds.map do |filteredFeed|
      query = filteredFeed.location.downcase
      if(filteredFeed.source === 'noah') then
        danger_index = noah_danger_index(query)
        lat = filteredFeed.data_result[:center][:lat]
        long = filteredFeed.data_result[:center][:lng]
      else
        danger_index = nasa_danger_index(query)
        lat = filteredFeed.data_result[:latitude]
        long = filteredFeed.data_result[:longitude]
      end

      {
        id: "item-#{filteredFeed.id}",
        country_name: filteredFeed.country_name ,
        city_name: filteredFeed.location ,
        danger_index: danger_index,
        data_source: filteredFeed.source,
        lat: lat,
        long: long,
      }
    end
  end

  private def noah_danger_index(query)
    count = findLocation(query, nil).count
    count > 10 ? 10 : count
  end

  private def findLocation(query, filtered)
    condition = 'lower(location) = ?'
    locations = History.where(condition, query)
    if filtered then
      locations.uniq{ |feed| feed.location }
    else
      locations
    end
  end

  private def nasa_danger_index(query)
    puts "query=#{query}"
    location = findLocation(query, nil)
    data = location.inject(0.0) do |data1, data2|
      if(data1 === 0) then
        num1 = data1
      else
        num1 = data1.to_f + data.to_f
      end
      num2 = data2.data_result[:fatalities].to_f + data2.data_result[:injuries].to_f
       # sum of fatalities and injuries
       # per recurring records
      num1 + num2
    end
    data/location.count
  end

end
