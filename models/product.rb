class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :price, type: BigDecimal
  field :age, type: Integer
  field :released_on, type: Date

  validates :name, presence: true
end