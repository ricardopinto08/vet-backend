class Owner < ApplicationRecord
  belongs_to :horse
  belongs_to :client
end
