class Horse < ApplicationRecord
  has_many :audits
  has_many :owners
  has_many :vets, through: :audits
  has_many :clients, through: :owners
end
