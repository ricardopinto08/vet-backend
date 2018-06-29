class Audit < ApplicationRecord
  belongs_to :horse
  belongs_to :vet
  has_many :examinations
end
