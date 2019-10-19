class History < ApplicationRecord
  store :data_result, coder: JSON
end
