require 'json'
desc "Task description"
task migrate_nasa_landslide: :environment do
  file = File.read("#{Rails.root}/public/landslide.json")

  parsed_data = JSON.parse(file)

  parsed_data.each do |data|
    puts "=== saving objectid: #{data['objectid']} ==="
    puts "=== counntry #{data['countrynam']} ==="
    history = History.new
    history.country_name = data['countrynam']
    history.location = data['adminname2']
    history.source = 'nasa'
    history.data_result = data
    history.save

  end

end