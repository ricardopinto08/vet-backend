class Client < User
  has_many :owners
  has_many :horses, through: :owners
  has_one :info, class_name: "ClientInfo", dependent: :destroy
  accepts_nested_attributes_for :info
end
