class Client < User
  has_many :owners
  has_many :horses, through: :owners
end
