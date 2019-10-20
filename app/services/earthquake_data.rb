require 'json'
class EarthquakeData
  def self.parsed_unknown_number_of_deaths
    data = []
    file = File.read("#{Rails.root}/public/unknown_number_of_deaths.json")

    parsed_data = JSON.parse(file)

    parsed_data.in_groups_of(300, false) do |group|
      group.each do |p|
        history = {}

        country_name = p['location'].partition(':').first
        location = p['location'].partition(':').last.partition(',').first

        history['country_name'] = country_name.strip
        history['location'] = location.strip
        history['source'] = 'https://github.com/plotly/datasets'
        history['hazard'] = 'earthquake'
        history['data_result'] = p

        data << history
      end
    end

    data

  end
end