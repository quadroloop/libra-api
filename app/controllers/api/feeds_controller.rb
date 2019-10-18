class Api::FeedsController < ApplicationController
  def index
    feeds = [
       {
           "id": "1",
           "country_name": "Philippines",
           "city_name": "Davao Oriental",
           "danger_index": 9.8,
           "lat": 21.85,
           "long": 108.45,
           "harzards": ["earthquake","landslide","flooding","storm_surge","typhoon","disease"
        
           ],
            "data_sources": ["nasa","noah"]
        },

        {
           "id": "2",
           "country_name": "Philippines",
           "city_name": "Davao Oriental",
           "danger_index": 9.8,
           "lat": 21.85,
           "long": 108.45,
           "harzards": ["earthquake","landslide","flooding","storm_surge","typhoon","disease"
        
           ],
            "data_sources": ["nasa","noah"]
        }

    ]

    render json: feeds
    
  end
end
