class Examination < ApplicationRecord
  belongs_to :audit
  has_many :annexeds
end
