require 'sinatra'
require 'mongoid'
require 'mongoid_paranoia'
require './models/product'
require './models/review'

Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")))
# no need to create or migrate db, as soon as your first record/document is created, your database will be created and you can see it in the mongo shell (type mongo in cli) using: <show dbs> command
# dont forget to run the mongo server: brew services start mongodb 

# To run the app: rackup -p 3000 -s puma


get '/' do
  "hello"
end

['/products', '/products/'].each do |path|
  get path do
    @products = Product.all
    erb :"products/index"
  end
end


#create
post "/products" do
 @product = Product.new(params[:product])
 if @product.save
  redirect "products/#{@product.id}"
 else
  erb :"products/new"
 end
end

# new
get "/products/new" do
  @product = Product.new
  erb :"products/new"
end





get '/products/:id' do
  @product = Product.find(params[:id])
  erb :"products/show"
end







