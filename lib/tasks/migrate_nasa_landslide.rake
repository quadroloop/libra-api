require 'json'
task migrate_nasa_landslide: :environment do
  file = File.read("#{Rails.root}/public/landslide.json")

  parsed_data = JSON.parse(file)

  parsed_data.each do |data|
    puts "=== saving objectid: #{data['objectid']} ==="
    puts "=== counntry #{data['countrynam']} ==="

    location = data['adminname2'] != 'obe' || data['adminname2'].blank?  ? data['adminname2'] : data['adminname1']

    history = History.new
    history.country_name = data['countrynam']
    history.location = location
    history.source = 'nasa'
    history.data_result = data
    history.save

  end

end