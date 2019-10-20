require 'net/http'
require 'json'
task migrate_noah_landslide: :environment do
  url = 'http://noah.up.edu.ph/api/landslide_maps'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  parsed_data  = JSON.parse(response)

  parsed_data.each do |group_data|
    group_data['layers'].each do |data|
      location = data['geoserver_layer'].partition(':').last.partition('_').first

      puts "=== saving mun_city_psgc: #{data['mun_city_psgc']} ==="
      puts "=== location #{location} ==="
      history = History.new
      history.country_name = 'Philippines'
      history.location = location.titleize
      history.source = 'noah'
      history.data_result = data
      history.hazard = 'landslide'
      history.save
    end
  end

end