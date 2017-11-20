class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia # this will do soft deletes, so destroying a record won't actually remove it from the database (it will only update its deleted_at attribute)
  # include Mongoid::Versioning # did not go through this but im guessing it will put your db under version control

  field :name, type: String
  field :price, type: BigDecimal
  field :age, type: Integer
  field :released_on, type: Date

  # this is just to override the id field to something prettier, aka friendly id
  # we are setting the default value of the id to a proc, changing it to the name attribute for this given model
  # Note that if you had existing records, they will no longer work, so you need to convert their ids to the new friendly id
  field :_id, type: String, default: -> { name.to_s.parameterize }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  # this is a referenced association which works similar to activerecord
  # has_many :reviews 

  # embedded association (see review model to see how it works)
  embeds_many :reviews
end






# Paranoia example

# $ irb
# irb(main):001:0> require './routes.rb'
# => true

# irb(main):002:0> p = Product.first
# => #<Product _id: 5a12fa48f8a01c0417e2ab15, created_at: 2017-11-20 15:52:40 UTC, updated_at: 2017-11-20 15:52:40 UTC, deleted_at(deleted_at): nil, name: "neww", price: "23", age: nil, released_on: nil>

# irb(main):003:0> p.destroy
# => true

# irb(main):004:0> p.first
# NoMethodError: undefined method `first' for #<Product:0x007fff02e03f40>
#   from (irb):4
#   from /usr/local/bin/irb:11:in `<main>'

# irb(main):005:0> p.count
# NoMethodError: undefined method `count' for #<Product:0x007fff02e03f40>
#   from (irb):5
#   from /usr/local/bin/irb:11:in `<main>'

# irb(main):006:0> Product.first
# => nil

# irb(main):007:0> Product.count
# => 0

# irb(main):008:0> p.restore
# => true

# irb(main):009:0> Product.count
# => 1

# irb(main):010:0> p
# => #<Product _id: 5a12fa48f8a01c0417e2ab15, created_at: 2017-11-20 15:52:40 UTC, updated_at: 2017-11-20 15:52:40 UTC, deleted_at(deleted_at): nil, name: "neww", price: "23", age: nil, released_on: nil>

# irb(main):011:0> Product.first
# => #<Product _id: 5a12fa48f8a01c0417e2ab15, created_at: 2017-11-20 15:52:40 UTC, updated_at: 2017-11-20 15:52:40 UTC, deleted_at(deleted_at): nil, name: "neww", price: "23", age: nil, released_on: nil>
