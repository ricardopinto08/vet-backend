class Vet < User
  has_many :audits
  has_many :horses, through: :audits
end
