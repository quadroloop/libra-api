class History < ApplicationRecord
  store :data_result, coder: JSON

  DEFAULT_HAZARDS = ['earthquake','landslide','flooding','storm_surge','typhoon','disease'].freeze

end
