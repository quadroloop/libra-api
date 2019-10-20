class Location
  def initialize(query)
    @query = query
  end

  def compute_danger_index
    danger_index = get_danger_index

    danger_count = danger_index.select{|k,v| v == true}.count

    danger_percentage = (danger_count.to_f / History::DEFAULT_HAZARDS.count.to_f ) * 100

    danger_percentage.to_f / 10
  end

  def get_lat_long
    nasa_data = @query.select{|q| q.source == 'nasa'}
    noah_data = @query.select{|q| q.source == 'noah'}

    nasa_lat_long(nasa_data).present? ? nasa_lat_long(nasa_data) : noah_lat_long(noah_data)

  end

  private

  def get_danger_index
    danger_index = {}
    History::DEFAULT_HAZARDS.each do |hazard|
      danger_index[hazard.to_sym] = @query.select{|q| q['hazard'] == hazard}.present?
    end
    danger_index.stringify_keys
  end


  def nasa_lat_long(query)
    return {} unless query.present?
    first_data = query.first

    {
      lat: first_data.data_result['latitude'],
      long: first_data.data_result['longitude']
    }.stringify_keys
    
  end

  def noah_lat_long(query)
    return {} unless query.present?
    first_data = query.first

    {
      lat: first_data.data_result['center']['lat'],
      long: first_data.data_result['center']['lng']
    }.stringify_keys
  end
end