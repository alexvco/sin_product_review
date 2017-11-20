class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String

  # embedded association (means all reviews data is within its product document, not stored as a separate document in Mongodb)
  # we can only fetch reviews through the product model and in fact you can't even create a new review on its own, 
  # its going to raise an exception because it expects it to exist within a parent document.
  embedded_in :product
end


# $ irb
# irb(main):002:0> require './routes.rb'
# => true

# irb(main):003:0> p = Product.first
# => #<Product _id: 5a12fa48f8a01c0417e2ab15, created_at: 2017-11-20 15:52:40 UTC, updated_at: 2017-11-20 15:52:40 UTC, name: "neww", price: "23", age: nil, released_on: nil>

# irb(main):004:0> p.reviews.create(content: "good stuff")
# => #<Review _id: 5a12fc8af8a01c04afc53f16, content: "good stuff">

# irb(main):005:0> p.reviews.size
# => 1

# ### all reviews data is within its product document, not stored as a separate document in Mongodb)
# irb(main):006:0> Review.count
# => 0

# Whenever you are defining an association in Mongoid ask yourseld will I need to fetch this record and work with it on its own outside of the parent,
# if so then you should use a has_many reference association instead of an embedded association.
# The advantage of an embedded association though is that all the data is right there within one document, 
# it does not need to perform separate queries in order to fetch the other associated documents.