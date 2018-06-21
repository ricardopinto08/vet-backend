class Audit < ApplicationRecord
  belongs_to :horse
  belongs_to :vet
end
